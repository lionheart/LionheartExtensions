//
//  UIView.swift
//  Upriise
//
//  Created by Daniel Loewenherz on 11/13/15.
//  Copyright © 2015 Upriise LLC. All rights reserved.
//

import UIKit

public extension UIView {
    func setContentSize(size: CGSize) {
        self.widthAnchor.constraintEqualToConstant(size.width).active = true
        self.heightAnchor.constraintEqualToConstant(size.height).active = true
    }

    func fillWidthOfSuperview() {
        self.fillWidthOfSuperview(margin: 0)
    }

    func fillHeightOfSuperview() {
        self.fillHeightOfSuperview(margin: 0)
    }

    func fillWidthOfSuperview(margin margin: CGFloat) {
        if let superview = self.superview {
            self.leftAnchor.constraintEqualToAnchor(superview.leftAnchor, constant: margin).active = true
            self.rightAnchor.constraintEqualToAnchor(superview.rightAnchor, constant: -margin).active = true
        }
    }

    func fillHeightOfSuperview(margin margin: CGFloat) {
        if let superview = self.superview {
            self.topAnchor.constraintEqualToAnchor(superview.topAnchor, constant: margin).active = true
            self.bottomAnchor.constraintEqualToAnchor(superview.bottomAnchor, constant: -margin).active = true
        }
    }

    func fillSuperview(theAxis: UILayoutConstraintAxis? = nil, margin: CGFloat = 0) {
        if let axis = theAxis {
            switch (axis) {
            case .Horizontal:
                self.fillWidthOfSuperview()

            case .Vertical:
                self.fillHeightOfSuperview()
            }
        }
        else {
            self.fillWidthOfSuperview()
            self.fillHeightOfSuperview()
        }
    }

    func addVisualFormatConstraints(format: String) {
        let views = [
            "view": self,
        ]

        self.addConstraints(format, views: views)
    }

    func addConstraints(format: String, metrics: [String: AnyObject]? = nil, views: [String: AnyObject]) {
        let options = NSLayoutFormatOptions(rawValue: 0)
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat(format, options: options, metrics: metrics, views: views)

        for constraint in constraints {
            constraint.active = true
        }
    }
}
