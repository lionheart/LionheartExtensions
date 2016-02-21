//
//  String.swift
//  Upriise
//
//  Created by Daniel Loewenherz on 11/13/15.
//  Copyright © 2015 Upriise LLC. All rights reserved.
//

import UIKit

public protocol LHSStringType {
    /**
     Conforming types must provide a getter for the length of the string.
     
     - returns: An `Int` representing the "length" of the string (understood that this can differ based on encoding).
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    var length: Int { get }

    /**
     Conforming types must provide a method to get the full range of the string.
     
     - returns: An `NSRange` representing the entire string.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func range() -> NSRange
}

public protocol LHSURLStringType {
    mutating func URLEncode()
    mutating func slugify() throws
}

extension String: LHSStringType, LHSURLStringType {}
extension NSString: LHSStringType {}
extension NSAttributedString: LHSStringType {}

public extension String {
    /**
     Returns an `NSRange` indicating the length of the `String`.
     
     - returns: An `NSRange`
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func range() -> NSRange {
        return NSMakeRange(0, characters.count)
    }

    var length: Int {
        return NSString(string: self).length
    }

    mutating func URLEncode() {
        if let string = stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
            self = string
        }
    }

    mutating func slugify() throws {
        let regex = try NSRegularExpression(pattern: "[ ]", options: NSRegularExpressionOptions())
        self = regex.stringByReplacingMatchesInString(self, options: NSMatchingOptions(), range: self.range(), withTemplate: "-").lowercaseString
    }
}

public extension NSString {
    /**
     Returns an `NSRange` indicating the length of the `NSString`.
     
     - returns: An `NSRange`
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func range() -> NSRange {
        return String(self).range()
    }
    
    func slugify() {
        return String(self).slugify()
    }
}

public extension NSAttributedString {
    /**
     Returns an `NSRange` indicating the length of the `NSAttributedString`.
     
     - returns: An `NSRange`
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func range() -> NSRange {
        return NSMakeRange(0, length)
    }
}

public extension NSMutableAttributedString {
    func addStringWithAttributes(string: String, attributes: [String: AnyObject]) {
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        appendAttributedString(attributedString)
    }
    
    func addAttribute(name: String, value: AnyObject) {
        addAttribute(name, value: value, range: range())
    }
    
    func addAttributes(attributes: [String: AnyObject]) {
        addAttributes(attributes, range: range())
    }
    
    func removeAttribute(name: String) {
        removeAttribute(name, range: range())
    }
}
