//
//  PetsNetwork.swift
//  VeterinaryClinic
//
//  Created by Sachin Daingade on 27/08/22.
//

import Foundation

public enum VCError: Error {
    case failToGetResponse
    case failToDecode
}

protocol PetsNetworkProtocol {
    static func getPets(completion: @escaping (Result<VCPets,Error>) -> Void)
}

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
