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
     Indicates that conforming types must provide a method to get the full range of the string.
     
     - returns: An `NSRange` representing the entire string.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func range() -> NSRange
}

extension String: LHSStringType {}
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
        return NSMakeRange(0, length)
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
