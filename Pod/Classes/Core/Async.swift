//
//  GCD.swift
//  Pods
//
//  Created by Daniel Loewenherz on 3/7/16.
//
//

import Foundation

public func async(_ queue: DispatchQueue, delay: Double = 0, callback: (Void) -> Void) {
    if delay > 0 {
        queue.after(when: DispatchTime.now() + Double((Int64)(delay * Double(NSEC_PER_MSEC))) / Double(NSEC_PER_SEC)) {
            callback()
        }
    }
    else {
        queue.async {
            callback()
        }
    }
}

public func async_main(delay: Double = 0, callback: (Void) -> Void) {
    async(DispatchQueue.main, delay: delay) {
        callback()
    }
}

public func async_default(delay: Double = 0, callback: (Void) -> Void) {
    async(DispatchQueue.global(attributes: DispatchQueue.GlobalAttributes.qosDefault), delay: delay) {
        callback()
    }
}

public func async_background(delay: Double = 0, callback: (Void) -> Void) {
    async(DispatchQueue.global(attributes: DispatchQueue.GlobalAttributes.qosBackground), delay: delay) {
        callback()
    }
}
