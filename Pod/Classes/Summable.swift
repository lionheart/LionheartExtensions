//
//  Summable.swift
//  Pods
//
//  Created by Daniel Loewenherz on 1/16/17.
//
//

import Foundation

protocol ExpressibleByDecimal {
    var decimalNumber: NSDecimalNumber { get }
    static func makeFromNumber(_ number: NSNumber) -> Self
}

protocol NSNumberBridgeable: ExpressibleByIntegerLiteral, ExpressibleByDecimal {
    var number: NSNumber { get }
    init(_ number: NSNumber)
}

extension NSNumberBridgeable {
    var decimalNumber: NSDecimalNumber { return NSDecimalNumber(decimal: number.decimalValue) }

    static func makeFromNumber(_ number: NSNumber) -> Self {
        return Self(number)
    }
}

//

extension Double: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension Float: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

//

extension Int: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension Int8: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension Int16: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension Int32: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension Int64: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension UInt: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension UInt8: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension UInt16: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension UInt32: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension UInt64: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension NSDecimalNumber: ExpressibleByDecimal {
    var decimalNumber: NSDecimalNumber { return self }

    static func makeFromNumber(_ number: NSNumber) -> Self {
        return self.init(decimal: number.decimalValue)
    }
}

extension Array where Element: ExpressibleByDecimal {
    var sum: Element {
        let value = reduce(0, { $0.1.decimalNumber.adding($0.0) })
        return Element.makeFromNumber(value)
    }
}
