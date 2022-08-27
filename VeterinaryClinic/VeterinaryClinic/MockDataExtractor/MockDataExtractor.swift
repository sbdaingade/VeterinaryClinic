//
//  MockDataExtractor.swift
//  VeterinaryClinic
//
//  Created by Sachin Daingade on 27/08/22.
//

import Foundation

protocol MockDataExtractor {
    func dataFromResource(_ resource: String) -> Data
    func decode<T:Decodable>(_ type: T.Type, resource: String) -> T
}

extension MockDataExtractor {
    
    func dataFromResource(_ resource: String) -> Data {
        guard let mockURL = Bundle.main.url(forResource: resource, withExtension: "json"), let mockData = try? Data(contentsOf: mockURL) else {
            fatalError("Fail to laod \(resource) from bundle")
        }
        return mockData
    }
    
    func decode<T:Decodable>(_ type: T.Type, resource: String) -> T {
        let data = dataFromResource(resource)
      //  let str = String(decoding: data, as: UTF8.self)
      //  debugPrint(str)
     
        guard let object = try? JSONDecoder().decode(type, from: data)  else {
            fatalError("fail to load json from \(resource) ")
        }
        return object
    }

}
