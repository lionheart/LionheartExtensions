//
//  Font.swift
//  Pods
//
//  Created by Daniel Loewenherz on 2/16/16.
//
//

import Foundation

public extension UIFont {
    /**
     Returns a display name for the font.
     
     - throws: A regular expression error, if a match cannot be found.
     - returns: A `String` representing the font name.
     - author: Dan Loewenherz
     - copyright: 2016
     - date: February 17, 2016
     */
    func displayName() throws -> String {
        let expression = try NSRegularExpression(pattern: "([a-z])([A-Z])", options: NSRegularExpressionOptions())
        let fontName = NSMutableString(string: self.fontName)
        expression.replaceMatchesInString(fontName, options: NSMatchingOptions(), range: fontName.range(), withTemplate: "$1 $2")
        let components = fontName.componentsSeparatedByString("-")
        return components.joinWithSeparator(" ")
    }
}