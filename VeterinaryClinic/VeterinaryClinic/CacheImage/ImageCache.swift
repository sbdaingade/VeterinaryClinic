//
//  ImageCache.swift
//  VeterinaryClinic
//
//  Created by Sachin Daingade on 29/08/22.
//

import UIKit

protocol ImageCacheProtocol {
    subscript(_ url: URL) -> UIImage? { get set }
}

struct CustomImageCache: ImageCacheProtocol {
    private let cache: NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        cache.countLimit = 100 // 100 items
        cache.totalCostLimit = 1024 * 1024 * 100 // 100 MB
        return cache
    }()
    
    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}
