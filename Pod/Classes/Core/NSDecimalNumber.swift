//
//  NSDecimalNumber.swift
//  Pods
//
//  Created by Daniel Loewenherz on 3/16/16.
//
//

import Foundation

/**

 - source: https://gist.github.com/mattt/1ed12090d7c89f36fd28
 */

extension NSDecimalNumber: Comparable {}

public func ==(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
    return lhs.compare(rhs) == .orderedSame
}

public func <(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
    return lhs.compare(rhs) == .orderedAscending
}

public prefix func -(value: NSDecimalNumber) -> NSDecimalNumber {
    return value.multiplying(by: NSDecimalNumber(mantissa: 1, exponent: 0, isNegative: true))
}

public func +(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.adding(rhs)
}

public func -(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.subtracting(rhs)
}

public func +=(lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
    lhs = lhs + rhs
}

public func -=(lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
    lhs = lhs - rhs
}

public func *=(lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
    lhs = lhs * rhs
}

public func *(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.multiplying(by: rhs)
}

public func /(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.dividing(by: rhs)
}

public func ^(lhs: NSDecimalNumber, rhs: Int) -> NSDecimalNumber {
    return lhs.raising(toPower: rhs)
}
