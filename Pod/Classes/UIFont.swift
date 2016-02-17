//
//  Font.swift
//  Pods
//
//  Created by Daniel Loewenherz on 2/16/16.
//
//

import Foundation

extension UIFont {
    public func displayName() throws -> String {
        let expression = try NSRegularExpression(pattern: "([a-z])([A-Z])", options: NSRegularExpressionOptions())
        let fontName = NSMutableString(string: self.fontName)
        expression.replaceMatchesInString(fontName, options: NSMatchingOptions(), range: fontName.range(), withTemplate: "$1 $2")
        let components = fontName.componentsSeparatedByString("-")
        return components.joinWithSeparator(" ")
    }
}