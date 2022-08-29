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
    
    public var description: String {
        switch self {
        case .failToGetResponse:
            return "fail to get response"
        case .failToDecode:
            return "Fail to decode"
        case .customError(let error):
            return error.localizedDescription
        }
    }
}

protocol PetsNetworkProtocol {
    static func getPets(completion: @escaping (Result<VCPets,Error>) -> Void)
}

// MARK: Write Code here for real API
final class PetsNetwork: PetsNetworkProtocol {
    static func getPets(completion: @escaping (Result<VCPets, Error>) -> Void) {
    }
}

// MARK: Fetch Mock Data 
public final class TestPetsNetwork: PetsNetworkProtocol {
    static func getPets(completion: @escaping (Result<VCPets, Error>) -> Void) {
        guard let pets = PetsMockGenerator().pets  else {
            completion(.failure(VCError.failToGetResponse))
            return
        }
        debugPrint("\(pets.pets.count)")
        completion(.success(pets))
    }
}
