//
//  UIWindow.swift
//  LionheartExtensions
//
//  Created by Daniel Loewenherz on 2/17/16.
//
//  Copyright 2016 Lionheart Software LLC
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
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
    class func takeScreenshotAndSaveToPath(path: String) -> Bool {
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