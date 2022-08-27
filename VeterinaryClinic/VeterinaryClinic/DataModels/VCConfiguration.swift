//
//  VCConfiguration.swift
//  VeterinaryClinic
//
//  Created by Sachin Daingade on 27/08/22.
//

import Foundation
// MARK: - Config
public struct VCConfiguration: Codable {
    let settings: Settings
}

// MARK: - Settings
public struct Settings: Codable {
    let isChatEnabled, isCallEnabled: Bool
    let workHours: String
}
