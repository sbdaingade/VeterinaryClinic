//
//  ImageCacheKey.swift
//  VeterinaryClinic
//
//  Created by Sachin Daingade on 29/08/22.
//

import SwiftUI

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCacheProtocol = CustomImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCacheProtocol {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
