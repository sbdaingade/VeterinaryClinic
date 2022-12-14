//
//  ConfigNetwork.swift
//  VeterinaryClinic
//
//  Created by Sachin Daingade on 27/08/22.
//

import Foundation


protocol ConfigNetworkProtocol {
    static func getConfigData(completion: @escaping (Result<VCConfiguration,VCError>) -> Void)
}

// MARK: Write Code here for real API
public final class ConfigNetwork: ConfigNetworkProtocol {
    static func getConfigData(completion: @escaping (Result<VCConfiguration, VCError>) -> Void) {
      
        if InternetMonitor.shared.isConnected != true {
            completion(.failure(VCError.internetIssue))
            return
        }
        var request = URLRequest(url: URL(string: "https://api.npoint.io/70b567adac1d0b60689b")!,timeoutInterval: Double.infinity)
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
                let vcConfiguration = try JSONDecoder().decode(VCConfiguration.self, from: data!)
                completion(.success(vcConfiguration))
                
            } catch let error {
                completion(.failure(VCError.customError(error)))
            }
        }.resume()
    }
}
