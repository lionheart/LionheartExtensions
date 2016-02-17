//
//  String.swift
//  Upriise
//
//  Created by Daniel Loewenherz on 11/13/15.
//  Copyright © 2015 Upriise LLC. All rights reserved.
//

import UIKit

public protocol LHSStringType {
    func range() -> NSRange
}

extension String: LHSStringType {}
extension NSString: LHSStringType {}
extension NSAttributedString: LHSStringType {}

public extension String {
    func range() -> NSRange {
        return NSMakeRange(0, characters.count)
    }
}

public extension NSString {
    func range() -> NSRange {
        return NSMakeRange(0, length)
    }
}

public extension NSAttributedString {
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
