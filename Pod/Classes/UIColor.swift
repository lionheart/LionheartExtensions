//
//  UIColor.swift
//
//  Created by Daniel Loewenherz on 7/12/15.
//  Copyright © 2015 Lionheart Software. All rights reserved.
//

import UIKit

public extension UIColor {
    convenience init(hex: Int64) {
        let r : CGFloat = CGFloat((hex>>24) & 0xff) / 255.0
        let g : CGFloat = CGFloat((hex>>16) & 0xff) / 255.0
        let b : CGFloat = CGFloat((hex>>8) & 0xff) / 255.0
        let a : CGFloat = CGFloat(hex & 0xff) / 255.0
        self.init(red: r, green: g, blue: b, alpha: a)
    }

    func lighten(ratio: CGFloat) -> UIColor {
        var rgba = [CGFloat](count: 4, repeatedValue: 0)
        self.getRed(&rgba[0], green: &rgba[1], blue: &rgba[2], alpha: &rgba[3])

        let r = Float(min(rgba[0] + ratio, 1))
        let g = Float(min(rgba[1] + ratio, 1))
        let b = Float(min(rgba[2] + ratio, 1))
        let a = Float(min(rgba[3] + ratio, 1))
        return UIColor(colorLiteralRed: r, green: g, blue: b, alpha: a)
    }

    func darken(ratio: CGFloat) -> UIColor {
        var rgba = [CGFloat](count: 4, repeatedValue: 0)
        self.getRed(&rgba[0], green: &rgba[1], blue: &rgba[2], alpha: &rgba[3])

        let r = Float(max(rgba[0] - ratio, 0))
        let g = Float(max(rgba[1] - ratio, 0))
        let b = Float(max(rgba[2] - ratio, 0))
        let a = Float(max(rgba[3] - ratio, 0))
        return UIColor(colorLiteralRed: r, green: g, blue: b, alpha: a)
    }
}