//
//  UIWindow.swift
//  Pods
//
//  Created by Daniel Loewenherz on 2/17/16.
//
//

import Foundation

/**
Helper methods for `UIWindow`.
*/

public extension UIWindow {
    /**
     Take a screenshot and save to the specified file path. Helpful for creating screenshots via automated tests.
     
     - parameter path: The path on the local filesystem to save the screenshot to.
     - returns: A bool indicating whether the save was successful.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    class func takeScreenshotAndSaveToPath(_ path: String) -> Bool {
        if let window = UIApplication.shared().keyWindow {
            let bounds = window.bounds
            UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
            window.drawHierarchy(in: bounds, afterScreenUpdates: true)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            let data = UIImagePNGRepresentation(image!)
            return ((try? data?.write(to: URL(fileURLWithPath: path), options: [.dataWritingAtomic])) != nil) ?? false
        }
        else {
            return false
        }
    }
}
