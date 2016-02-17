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

extension String: LHSStringType {
    public func range() -> NSRange {
        return NSMakeRange(0, self.characters.count)
    }
}

extension NSString: LHSStringType {
    public func range() -> NSRange {
        return NSMakeRange(0, self.length)
    }
}