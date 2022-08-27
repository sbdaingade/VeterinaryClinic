//
//  PetsMockGenerator.swift
//  VeterinaryClinic
//
//  Created by Sachin Daingade on 27/08/22.
//

import Foundation

public struct PetsMockGenerator: MockDataExtractor {
    public var pets: VCPets? {
        return decode(VCPets.self, resource: "pets")
    }
    init() {}
}
