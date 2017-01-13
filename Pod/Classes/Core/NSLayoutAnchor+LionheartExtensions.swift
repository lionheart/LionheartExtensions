//
//  NSLayoutAnchor+LionheartExtensions.swift
//  Pods
//
//  Created by Daniel Loewenherz on 1/13/17.
//
//

import UIKit

precedencegroup ConstraintPrecedence {
    lowerThan: AdditionPrecedence
    associativity: left
    assignment: false
}

infix operator ~~: ConstraintPrecedence
infix operator ≥≥: ConstraintPrecedence
infix operator ≤≤: ConstraintPrecedence

public protocol HasAnchor {
    associatedtype Anchor

    var constant: CGFloat { get }
    var anchor: Anchor { get }
}

public protocol HasAnchorWithMethods: HasAnchor {
    func constraint(equalTo: Anchor, constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo: Anchor, constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo: Anchor, constant: CGFloat) -> NSLayoutConstraint
}

public struct LayoutContainer<T>: HasAnchor {
    public typealias Anchor = T

    public var constant: CGFloat
    public var anchor: Anchor

    init(anchor: Anchor, constant: Double) {
        self.constant = CGFloat(constant)
        self.anchor = anchor
    }
}

extension NSLayoutYAxisAnchor: HasAnchorWithMethods {
    public typealias Anchor = NSLayoutAnchor<NSLayoutYAxisAnchor>

    public var constant: CGFloat { return 0 }
    public var anchor: Anchor { return self }
}

extension NSLayoutXAxisAnchor: HasAnchorWithMethods {
    public typealias Anchor = NSLayoutAnchor<NSLayoutXAxisAnchor>

    public var constant: CGFloat { return 0 }
    public var anchor: Anchor { return self }
}

extension NSLayoutDimension: HasAnchorWithMethods {
    public typealias Anchor = NSLayoutAnchor<NSLayoutDimension>

    public var constant: CGFloat { return 0 }
    public var anchor: Anchor { return self }
}

public extension HasAnchorWithMethods {
    static func ~~<T: HasAnchor>(lhs: Self, rhs: T) -> NSLayoutConstraint where T.Anchor == Anchor {
        return lhs.constraint(equalTo: rhs.anchor, constant: rhs.constant)
    }

    static func ≤≤<T: HasAnchor>(lhs: Self, rhs: T) -> NSLayoutConstraint where T.Anchor == Anchor {
        return lhs.constraint(lessThanOrEqualTo: rhs.anchor, constant: rhs.constant)
    }

    static func ≥≥<T: HasAnchor>(lhs: Self, rhs: T) -> NSLayoutConstraint where T.Anchor == Anchor {
        return lhs.constraint(greaterThanOrEqualTo: rhs.anchor, constant: rhs.constant)
    }

    static func +(lhs: Self, rhs: Double) -> LayoutContainer<Anchor> {
        return LayoutContainer(anchor: lhs.anchor, constant: rhs)
    }

    static func -(lhs: Self, rhs: Double) -> LayoutContainer<Anchor> {
        return LayoutContainer(anchor: lhs.anchor, constant: -rhs)
    }
}
