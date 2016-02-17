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
        getRed(&rgba[0], green: &rgba[1], blue: &rgba[2], alpha: &rgba[3])

        let r = Float(min(rgba[0] + ratio, 1))
        let g = Float(min(rgba[1] + ratio, 1))
        let b = Float(min(rgba[2] + ratio, 1))
        let a = Float(min(rgba[3] + ratio, 1))
        return UIColor(colorLiteralRed: r, green: g, blue: b, alpha: a)
    }

    func darken(ratio: CGFloat) -> UIColor {
        var rgba = [CGFloat](count: 4, repeatedValue: 0)
        getRed(&rgba[0], green: &rgba[1], blue: &rgba[2], alpha: &rgba[3])

        let r = Float(max(rgba[0] - ratio, 0))
        let g = Float(max(rgba[1] - ratio, 0))
        let b = Float(max(rgba[2] - ratio, 0))
        let a = Float(max(rgba[3] - ratio, 0))
        return UIColor(colorLiteralRed: r, green: g, blue: b, alpha: a)
    }
    
    func isDark() -> Bool {
        var rgba = [CGFloat](count: 4, repeatedValue: 0)
        
        let converted = getRed(&rgba[0], green: &rgba[1], blue: &rgba[2], alpha: &rgba[3])
        if !converted {
            return false
        }

        let R = Float(rgba[0])
        let G = Float(rgba[1])
        let B = Float(rgba[2])
        let A = Float(rgba[3])

        // Formula derived from here:
        // http://www.w3.org/WAI/ER/WD-AERT/#color-contrast

        // Alpha blending:
        // http://stackoverflow.com/a/746937/39155
        let newR: Float = (255 * (1 - A) + 255 * R * A) / 255
        let newG: Float = (255 * (1 - A) + 255 * G * A) / 255
        let newB: Float = (255 * (1 - A) + 255 * B * A) / 255
        return ((newR * 255 * 299) + (newG * 255 * 587) + (newB * 255 * 114)) / 1000 < 200
    }
}