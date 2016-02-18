//
//  UIWindow.swift
//  Pods
//
//  Created by Daniel Loewenherz on 2/17/16.
//
//

import Foundation

public extension UIWindow {
    /**
     Take a screenshot and save to the specified file path. Helpful for creating screenshots via automated tests.
     
     - parameter path: The path on the local filesystem to save the screenshot to.
     - returns: A bool indicating whether the save was successful.
     - author: Dan Loewenherz
     - copyright: 2016
     - date: February 17, 2016
     */
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