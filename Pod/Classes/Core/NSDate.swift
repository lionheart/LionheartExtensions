//
//  NSDate.swift
//  LionheartExtensions
//
//  Created by Daniel Loewenherz on 3/3/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import UIKit

extension Date: Comparable { }

public func <=(lhs: Date, rhs: Date) -> Bool {
    return lhs.compare(rhs) != .orderedDescending
}

public func >=(lhs: Date, rhs: Date) -> Bool {
    return lhs.compare(rhs) != .orderedAscending
}

public func >(lhs: Date, rhs: Date) -> Bool {
    return lhs.compare(rhs) == .orderedDescending
}

public func <(lhs: Date, rhs: Date) -> Bool {
    return lhs.compare(rhs) == .orderedAscending
}
