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

public protocol AxisAnchor: HasAnchor {
    func constraint(equalTo: Anchor, constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo: Anchor, constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo: Anchor, constant: CGFloat) -> NSLayoutConstraint
}

public protocol DimensionAnchor: HasAnchor {
    var multiplier: CGFloat { get }

    func constraint(equalToConstant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualToConstant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualToConstant: CGFloat) -> NSLayoutConstraint

    func constraint(equalTo: Anchor, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo: Anchor, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo: Anchor, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint
}

public struct LayoutContainer<T>: HasAnchor {
    public typealias Anchor = T

    public var multiplier: CGFloat
    public var constant: CGFloat
    public var anchor: Anchor

    init(anchor: Anchor, constant: CGFloat) {
        self.constant = constant
        self.multiplier = 1
        self.anchor = anchor
    }
}

extension LayoutContainer where T: DimensionAnchor {
    init(container: LayoutContainer, multiplier: Double) {
        self.constant = container.constant
        self.multiplier = CGFloat(multiplier)
        self.anchor = container.anchor
    }

    static func *(lhs: LayoutContainer, rhs: Double) -> LayoutContainer {
        return LayoutContainer(container: lhs, multiplier: rhs)
    }
}

extension NSLayoutYAxisAnchor: AxisAnchor {
    public typealias Anchor = NSLayoutAnchor<NSLayoutYAxisAnchor>

    public var constant: CGFloat { return 0 }
    public var anchor: Anchor { return self }
}

extension NSLayoutXAxisAnchor: AxisAnchor {
    public typealias Anchor = NSLayoutAnchor<NSLayoutXAxisAnchor>

    public var constant: CGFloat { return 0 }
    public var anchor: Anchor { return self }
}

extension NSLayoutDimension: DimensionAnchor {
    public typealias Anchor = NSLayoutDimension

    public var multiplier: CGFloat { return 1 }
    public var constant: CGFloat { return 0 }
    public var anchor: Anchor { return self }
}

public extension DimensionAnchor where Anchor: DimensionAnchor {
    @discardableResult
    static func ~~<T: DimensionAnchor>(lhs: Self, rhs: T) -> NSLayoutConstraint where T.Anchor == Anchor {
        let constraint = lhs.constraint(equalTo: rhs.anchor, multiplier: rhs.multiplier, constant: rhs.constant)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    static func ≤≤<T: DimensionAnchor>(lhs: Self, rhs: T) -> NSLayoutConstraint where T.Anchor == Anchor {
        let constraint = lhs.constraint(lessThanOrEqualTo: rhs.anchor, multiplier: rhs.multiplier, constant: rhs.constant)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    static func ≥≥<T: DimensionAnchor>(lhs: Self, rhs: T) -> NSLayoutConstraint where T.Anchor == Anchor {
        let constraint = lhs.constraint(greaterThanOrEqualTo: rhs.anchor, multiplier: rhs.multiplier, constant: rhs.constant)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    static func ~~(lhs: Self, rhs: CGFloat) -> NSLayoutConstraint {
        let constraint = lhs.constraint(equalToConstant: rhs)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    static func ≤≤(lhs: Self, rhs: CGFloat) -> NSLayoutConstraint {
        let constraint = lhs.constraint(lessThanOrEqualToConstant: rhs)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    static func ≥≥(lhs: Self, rhs: CGFloat) -> NSLayoutConstraint {
        let constraint = lhs.constraint(greaterThanOrEqualToConstant: rhs)
        constraint.isActive = true
        return constraint
    }
}

public extension AxisAnchor where Anchor: AxisAnchor {
    @discardableResult
    static func ~~<T: AxisAnchor>(lhs: Self, rhs: T) -> NSLayoutConstraint where T.Anchor == Anchor {
        let constraint = lhs.constraint(equalTo: rhs.anchor, constant: rhs.constant)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    static func ≤≤<T: AxisAnchor>(lhs: Self, rhs: T) -> NSLayoutConstraint where T.Anchor == Anchor {
        let constraint = lhs.constraint(lessThanOrEqualTo: rhs.anchor, constant: rhs.constant)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    static func ≥≥<T: AxisAnchor>(lhs: Self, rhs: T) -> NSLayoutConstraint where T.Anchor == Anchor {
        let constraint = lhs.constraint(greaterThanOrEqualTo: rhs.anchor, constant: rhs.constant)
        constraint.isActive = true
        return constraint
    }
}

public extension HasAnchor {
    static func +(lhs: Self, rhs: CGFloat) -> LayoutContainer<Anchor> {
        return LayoutContainer(anchor: lhs.anchor, constant: rhs)
    }

    static func -(lhs: Self, rhs: CGFloat) -> LayoutContainer<Anchor> {
        return LayoutContainer(anchor: lhs.anchor, constant: -rhs)
    }
}
