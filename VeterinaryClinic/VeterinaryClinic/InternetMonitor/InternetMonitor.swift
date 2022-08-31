//
//  InternetMonitor.swift
//  VeterinaryClinic
//
//  Created by Sachin Daingade on 31/08/22.
//

import Foundation
import Network

final class InternetMonitor {
    
    static let shared = InternetMonitor()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    public private(set) var isConnected: Bool = false
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
