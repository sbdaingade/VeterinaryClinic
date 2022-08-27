//
//  VCPets.swift
//  VeterinaryClinic
//
//  Created by Sachin Daingade on 27/08/22.
//

import Foundation

public struct VCPets: Codable {
    let pets: [Pet]
}

// MARK: - Pet
public struct Pet: Codable , Identifiable{
    public var id = UUID().uuidString
    let imageURL: String
    let title: String
    let contentURL: String
    let dateAdded: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case title
        case contentURL = "content_url"
        case dateAdded = "date_added"
    }
}
