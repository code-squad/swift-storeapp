//
//  ReachabilityManager.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 5. 17..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

class ReachabilityManager {
    static let sharedInstance = ReachabilityManager()
    private var networkManager: Reachability?

    private init() {
        networkManager = Reachability.init(hostName: Keyword.Network.hostName.value)
    }

    func isConnected() -> Bool {
        guard let networkManager = networkManager else { return false }
        return networkManager.currentReachabilityStatus().rawValue != 0
    }

    // https://medium.com/@marcosantadev/network-reachability-with-swift-576ca5070e4b
    private let reachability = SCNetworkReachabilityCreateWithName(nil, Keyword.Network.hostName.value)
    // Queue where the `SCNetworkReachability` callbacks run
    private let queue = DispatchQueue.main
    // We use it to keep a backup of the last flags read.
    private var currentReachabilityFlags: SCNetworkReachabilityFlags?
    // Flag used to avoid starting listening if we are already listening
    private var isListening = false
    // Starts listening
    func start() {
        // Checks if we are already listening
        guard !isListening else { return }
        // Optional binding since `SCNetworkReachabilityCreateWithName` returns an optional object
        guard let reachability = reachability else { return }
        // Creates a context
        var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        // Sets `self` as listener object
        context.info = UnsafeMutableRawPointer(Unmanaged<ReachabilityManager>.passUnretained(self).toOpaque())
        let callbackClosure: SCNetworkReachabilityCallBack? = {
            (reachability:SCNetworkReachability, flags: SCNetworkReachabilityFlags, info: UnsafeMutableRawPointer?) in
            guard let info = info else { return }
            // Gets the `Handler` object from the context info
            let handler = Unmanaged<ReachabilityManager>.fromOpaque(info).takeUnretainedValue()
            DispatchQueue.main.async {
                handler.checkReachability(flags: flags)
            }
        }
        // Registers the callback. `callbackClosure` is the closure where we manage the callback implementation
        if !SCNetworkReachabilitySetCallback(reachability, callbackClosure, &context) {
            // Not able to set the callback
        }
        // Sets the dispatch queue which is `DispatchQueue.main` for this example. It can be also a background queue
        if !SCNetworkReachabilitySetDispatchQueue(reachability, queue) {
            // Not able to set the queue
        }
        // Runs the first time to set the current flags
        queue.async {
            // Resets the flags stored, in this way `checkReachability` will set the new ones
            self.currentReachabilityFlags = nil
            // Reads the new flags
            var flags = SCNetworkReachabilityFlags()
            SCNetworkReachabilityGetFlags(reachability, &flags)
            self.checkReachability(flags: flags)
        }
        isListening = true
    }
    // Called inside `callbackClosure`
    private func checkReachability(flags: SCNetworkReachabilityFlags) {
        if currentReachabilityFlags != flags {
            // 🚨 Network state is changed 🚨
            // Stores the new flags
            NotificationCenter.default.post(name: .connectionChanged, object: nil)
            currentReachabilityFlags = flags
        }
    }
    // Stops listening
    func stop() {
        // Skips if we are not listening
        // Optional binding since `SCNetworkReachabilityCreateWithName` returns an optional object
        guard isListening,
            let reachability = reachability
            else { return }
        // Remove callback and dispatch queue
        SCNetworkReachabilitySetCallback(reachability, nil, nil)
        SCNetworkReachabilitySetDispatchQueue(reachability, nil)
        isListening = false
    }

}
