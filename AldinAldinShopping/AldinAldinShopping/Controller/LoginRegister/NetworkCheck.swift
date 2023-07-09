//
//  NetworkCheck.swift
//  AldinAldinShopping
//
//  Created by Mustafa Aktas on 9.07.2023.
//

import Foundation
import Network

@available(iOS 12.0, *)
public class NetworkUtility {
    public static func checkNetworkConnectivity() -> Bool {
        let pathMonitor = NWPathMonitor()
        let semaphore = DispatchSemaphore(value: 0)
        var isConnected = false

        pathMonitor.pathUpdateHandler = { path in
            isConnected = path.status == .satisfied
            semaphore.signal()
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        pathMonitor.start(queue: queue)

        _ = semaphore.wait(timeout: .now() + 2)

        return isConnected
    }
}
