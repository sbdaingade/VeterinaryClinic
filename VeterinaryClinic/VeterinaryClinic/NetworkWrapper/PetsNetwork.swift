//
//  PetsNetwork.swift
//  VeterinaryClinic
//
//  Created by Sachin Daingade on 27/08/22.
//

import Foundation

public enum VCError: Error, CustomStringConvertible {
    case failToGetResponse
    case failToDecode
    case customError(Error)
    case internetIssue
    
    public var description: String {
        switch self {
        case .failToGetResponse:
            return "fail to get response"
        case .failToDecode:
            return "Fail to decode"
        case  .internetIssue:
            return "Check internet connection"
        case .customError(let error):
            return error.localizedDescription
        }
    }
}

protocol PetsNetworkProtocol {
    static func getPets(completion: @escaping (Result<VCPets,VCError>) -> Void)
}

// MARK: Write Code here for real API
final class PetsNetwork: PetsNetworkProtocol {
    
    static func getPets(completion: @escaping (Result<VCPets, VCError>) -> Void) {
        
         if InternetMonitor.shared.isConnected != true {
             completion(.failure(VCError.internetIssue))
            return
        }
        
        var request = URLRequest(url: URL(string: "https://api.npoint.io/89bc67a9845e640ae6ce")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        let defaultConfiguration = URLSessionConfiguration.default
        defaultConfiguration.waitsForConnectivity = true
        defaultConfiguration.timeoutIntervalForRequest = 300
        let sharedSession = URLSession(configuration: defaultConfiguration)
        
        sharedSession.dataTask(with: request) { data,response,error in
            if error != nil {
                completion(.failure(VCError.customError(error!)))
                return
            }
            do {
                let pets = try JSONDecoder().decode(VCPets.self, from: data!)
                completion(.success(pets))
                
            } catch let error {
                completion(.failure(VCError.customError(error)))
            }
        }.resume()
    }
}

// MARK: Fetch Mock Data 
public final class TestPetsNetwork: PetsNetworkProtocol {
    static func getPets(completion: @escaping (Result<VCPets, VCError>) -> Void) {
        guard let pets = PetsMockGenerator().pets  else {
            completion(.failure(VCError.failToGetResponse))
            return
        }
        debugPrint("\(pets.pets.count)")
        completion(.success(pets))
    }
}
