//
//  ConfigMockGenerator.swift
//  VeterinaryClinic
//
//  Created by Sachin Daingade on 27/08/22.
//

import Foundation
public struct ConfigMockGenerator: MockDataExtractor {
    public var config: VCConfiguration? {
        return decode(VCConfiguration.self, resource: "config")
    }
    init() {}
}
