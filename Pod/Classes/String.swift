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

public extension String {
    func range() -> NSRange {
        return NSMakeRange(0, self.characters.count)
    }
}

public extension NSString {
    func range() -> NSRange {
        return NSMakeRange(0, self.length)
    }
}