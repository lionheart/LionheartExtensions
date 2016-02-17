//
//  UIApplication.swift
//  Pods
//
//  Created by Daniel Loewenherz on 2/16/16.
//
//

import Foundation

extension UIApplication {
    static var LHSNumberOfCallsToSetVisible = 0

    public func formattedVersionString() -> String? {
        if let info = NSBundle.mainBundle().infoDictionary,
            appVersion = info["CFBundleShortVersionString"] as? String,
            bundleVersion = info["CFBundleVersion"] as? String {
                return String(format: "%@ (%@)", appVersion, bundleVersion)
        }
        else {
            return nil
        }
    }
}