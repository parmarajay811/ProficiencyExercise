//
//  Reachability.swift
//  ProficiencyExercise
//
//  Created by Ajay Parmar on 7/26/18.
//  Copyright © 2018 Ajay Parmar. All rights reserved.
//

import Foundation
import SystemConfiguration

struct Reachability {
     func isConnectedToNetwork() -> Bool {
        var sockAddress = sockaddr_in()
        sockAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        sockAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &sockAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachableNetwork = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachableNetwork && !needsConnection)
    }
}


