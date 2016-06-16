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
     Returns a display name for a given `UIFont`.
     
     - throws: A regular expression error, if a match cannot be found.
     - returns: A `String` representing the font name.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func displayName() throws -> String {
        let expression = try RegularExpression(pattern: "([a-z])([A-Z])", options: RegularExpression.Options())
        let fontName = NSMutableString(string: self.fontName)
        expression.replaceMatches(in: fontName, options: RegularExpression.MatchingOptions(), range: fontName.range(), withTemplate: "$1 $2")
        let components = fontName.components(separatedBy: "-")
        return components.joined(separator: " ")
    }
}
