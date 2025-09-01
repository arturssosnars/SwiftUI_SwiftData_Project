//
//  NetworkMonitor.swift
//  HomeworkProjectApp
//
//  Created by Arturs Sosnars on 29/08/2025.
//

import Network

actor NetworkMonitor {
    enum NetworkStatus {
        case inProgress
        case ready(isConnected: Bool)
    }
    
    static let shared = NetworkMonitor()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    private var status: NetworkStatus = .inProgress
    private var continuation: CheckedContinuation<Bool, Never>?

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            Task {
                await self?.updateStatus(path.status == .satisfied)
            }
        }
        monitor.start(queue: queue)
    }

    private func updateStatus(_ connected: Bool) {
        status = .ready(isConnected: connected)
        continuation?.resume(returning: connected)
        continuation = nil
    }

    func isConnected() async -> Bool {
        if case let .ready(isConnected) = status {
            return isConnected
        }

        return await withCheckedContinuation { continuation in
            self.continuation = continuation
        }
    }
}
