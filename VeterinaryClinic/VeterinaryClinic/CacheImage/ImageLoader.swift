//
//  ImageLoader.swift
//  VeterinaryClinic
//
//  Created by Sachin Daingade on 29/08/22.
//

import Combine
import UIKit

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private(set) var isLoading = false
    private let url: URL
    private var cache: ImageCacheProtocol?
    private var cancallables = Set<AnyCancellable>()
    
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
    
    init(strUrl: String, cache: ImageCacheProtocol? = nil) {
        self.url = URL(string: strUrl)!
        self.cache = cache
    }
    
    func load() {
        guard !isLoading else { return }
        
        if let image = cache?[url] {
            self.image = image
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveOutput: { [weak self] in self?.cache($0) },
                          receiveCompletion: { [weak self] _ in self?.onFinish() },
                          receiveCancel: { [weak self] in self?.onFinish() })
            .subscribe(on: Self.imageProcessingQueue)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
            .store(in: &cancallables)
    }
    
    func cancel() {
        cancallables.forEach{$0.cancel()}
    }
    
    private func onStart() {
        isLoading = true
    }
    
    private func onFinish() {
        isLoading = false
    }
    
    private func cache(_ image: UIImage?) {
        image.map { cache?[url] = $0 }
    }
    
    deinit {
        cancallables.forEach{$0.cancel()}
    }
}
