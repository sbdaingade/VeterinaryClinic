//
//  LoadingStates.swift
//  VeterinaryClinic
//
//  Created by Sachin Daingade on 31/08/22.
//

import Foundation
import Combine

public enum LoadingStates : Equatable {
    case idle
    case loading
    case failed(String)
    case infoMessage(String,String)
}

public struct IdentifiableObject<T: Hashable>: Identifiable {
    public var id: Int {
        return value.hashValue
    }

    public let value: T

    public init(_ value: T) {
        self.value = value
    }
}
