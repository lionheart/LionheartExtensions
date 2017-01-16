//
//  Summable.swift
//  Pods
//
//  Created by Daniel Loewenherz on 1/16/17.
//
//

import Foundation

protocol Summable {
    static var zero: Self { get }
    static func +(lhs: Self, rhs: Self) -> Self
}

//

extension Double: Summable {
    static var zero: Double = 0
}

extension Float: Summable {
    static var zero: Float = 0
}

//

extension Int: Summable {
    static var zero = 0
}

extension Int8: Summable {
    static var zero: Int8 = 0
}

extension Int16: Summable {
    static var zero: Int16 = 0
}

extension Int32: Summable {
    static var zero: Int32 = 0
}

extension Int64: Summable {
    static var zero: Int64 = 0
}

extension UInt: Summable {
    static var zero: UInt = 0
}

extension UInt8: Summable {
    static var zero: UInt8 = 0
}

extension UInt16: Summable {
    static var zero: UInt16 = 0
}

extension UInt32: Summable {
    static var zero: UInt32 = 0
}

extension UInt64: Summable {
    static var zero: UInt64 = 0
}

//

extension NSDecimalNumber: Summable {
}

extension Array where Element: Summable {
    var sum: Element {
        return reduce(Element.zero, { $0.0 + $0.1 })
    }
}
