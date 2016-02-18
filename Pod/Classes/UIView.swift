//
//  UIView.swift
//  Upriise
//
//  Created by Daniel Loewenherz on 11/13/15.
//  Copyright © 2015 Upriise LLC. All rights reserved.
//

import Foundation

public extension UIView {
    /**
     Remove all subviews.
     */
    func removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }

    /**
    Set the height of this view to a specified value using Auto Layout.
    
    - parameter height: as
    */
    func setHeight(height: CGFloat) {
        heightAnchor.constraintEqualToConstant(height).active = true
    }

    func setContentSize(size: CGSize) {
        widthAnchor.constraintEqualToConstant(size.width).active = true
        heightAnchor.constraintEqualToConstant(size.height).active = true
    }

    func fillWidthOfSuperview() {
        fillWidthOfSuperview(margin: 0)
    }

    func fillHeightOfSuperview() {
        fillHeightOfSuperview(margin: 0)
    }

    func fillWidthOfSuperview(margin margin: CGFloat) {
        if let superview = superview {
            leftAnchor.constraintEqualToAnchor(superview.leftAnchor, constant: margin).active = true
            rightAnchor.constraintEqualToAnchor(superview.rightAnchor, constant: -margin).active = true
        }
    }

    func fillHeightOfSuperview(margin margin: CGFloat) {
        if let superview = superview {
            topAnchor.constraintEqualToAnchor(superview.topAnchor, constant: margin).active = true
            bottomAnchor.constraintEqualToAnchor(superview.bottomAnchor, constant: -margin).active = true
        }
    }

    func fillSuperview(theAxis: UILayoutConstraintAxis? = nil, margin: CGFloat = 0) {
        if let axis = theAxis {
            switch (axis) {
            case .Horizontal:
                fillWidthOfSuperview(margin: margin)

            case .Vertical:
                fillHeightOfSuperview(margin: margin)
            }
        }
        else {
            fillWidthOfSuperview(margin: margin)
            fillHeightOfSuperview(margin: margin)
        }
    }

    func addVisualFormatConstraints(format: String) {
        let views = [
            "view": self,
        ]

        addConstraints(format, views: views)
    }

    func addConstraints(format: String, metrics: [String: AnyObject]? = nil, views: [String: UIView]) {
        let options = NSLayoutFormatOptions(rawValue: 0)
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat(format, options: options, metrics: metrics, views: views)

        for constraint in constraints {
            constraint.active = true
        }
    }
    
    // MARK - Geometry
    
    func distanceToPoint(point: CGPoint) -> Float {
        if CGRectContainsPoint(frame, point) {
            return 0
        }

        var closest: CGPoint = frame.origin
        let size = frame.size
        if frame.origin.x + size.width < point.x {
            closest.x += size.width
        }
        else if point.x > frame.origin.x {
            closest.x = point.x
        }
        
        if frame.origin.y + size.height < point.y {
            closest.y += size.height
        }
        else if point.y > frame.origin.y {
            closest.y = point.y
        }

        let a = powf(Float(closest.y-point.y), 2)
        let b = powf(Float(closest.x-point.x), 2)
        return sqrtf(a + b)
    }
    
    // MARK - Misc
    
    func centerRect() -> CGRect {
        return CGRect(x: CGRectGetWidth(frame) / 2, y: CGRectGetHeight(frame), width: 1, height: 1)
    }
}
