//
//  ConfigNetwork.swift
//  VeterinaryClinic
//
//  Created by Sachin Daingade on 27/08/22.
//

import Foundation


protocol ConfigNetworkProtocol {
    static func getConfigData(completion: @escaping (Result<VCConfiguration,Error>) -> Void)
}

// MARK: Write Code here for real API
public final class ConfigNetwork: ConfigNetworkProtocol {
    static func getConfigData(completion: @escaping (Result<VCConfiguration, Error>) -> Void) {
    }
}

// MARK: Fetch Mock Data
public final class TestConfigNetwork: ConfigNetworkProtocol {
    static func getConfigData(completion: @escaping (Result<VCConfiguration, Error>) -> Void) {
        guard let config = ConfigMockGenerator().config  else {
            completion(.failure(VCError.failToGetResponse))
            return
        }
        debugPrint("\(config.settings)")
        completion(.success(config))
    }
}
