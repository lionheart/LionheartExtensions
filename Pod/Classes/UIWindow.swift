//
//  UIWindow.swift
//  Pods
//
//  Created by Daniel Loewenherz on 2/17/16.
//
//

import Foundation

public extension UIWindow {
    func takeScreenshotAndSaveToPath(path: String) -> Bool {
        if let window = UIApplication.sharedApplication().keyWindow {
            let bounds = window.bounds
            UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
            window.drawViewHierarchyInRect(bounds, afterScreenUpdates: true)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            let data = UIImagePNGRepresentation(image)
            return data?.writeToFile(path, atomically: true) ?? false
        }
        else {
            return false
        }
    }
}