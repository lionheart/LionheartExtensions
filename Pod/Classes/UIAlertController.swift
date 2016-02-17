//
//  UIAlertController.swift
//  Pods
//
//  Created by Daniel Loewenherz on 2/17/16.
//
//

import Foundation

public extension UIAlertController {
    func actionSheetWithTitle(title: String) -> UIAlertController {
        return UIAlertController(title: title, message: nil, preferredStyle: .ActionSheet)
    }
    
    func alertViewWithTitle(title: String, message: String) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .Alert)
    }
    
    func addActionWithTitle(title: String, style: UIAlertActionStyle, handler: ((UIAlertAction) -> Void)?) {
        addAction(UIAlertAction(title: title, style: style, handler: handler))
    }
}