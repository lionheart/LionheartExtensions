//
//  Copyright 2016 Lionheart Software LLC
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//

import UIKit

/**
 An easy way to represent colors through hex, RGB, and RGBA values.

 - author: Daniel Loewenherz
 - copyright: ©2016 Lionheart Software LLC
 - date: December 13, 2016
 */
public enum ColorRepresentation: ExpressibleByIntegerLiteral, ExpressibleByArrayLiteral, ExpressibleByStringLiteral {
    public typealias IntegerLiteralType = Int
    public typealias Element = Float

    public typealias UnicodeScalarLiteralType = StringLiteralType
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    public typealias StringLiteralType = String

    case hex(Int)
    case rgb(Int, Int, Int)
    case rgba(Int, Int, Int, Float)
    case invalid

    public init(integerLiteral value: IntegerLiteralType) {
        self = .hex(value)
    }

    public init(arrayLiteral elements: Element...) {
        let intElements = elements.map { Int($0) }
        if elements.count == 3 {
            self = .rgb(intElements[0], intElements[1], intElements[2])
        } else if elements.count == 4 {
            self = .rgba(intElements[0], intElements[1], intElements[2], elements[3])
        } else {
            self = .hex(0)
        }
    }

    init(fromString string: String) {
        let hexColorRegularExpression = try! NSRegularExpression(pattern: "^#?([0-9A-Fa-f]{6}|[0-9A-Fa-f]{3})$", options: NSRegularExpression.Options())
        let rgbColorRegularExpression = try! NSRegularExpression(pattern: "^rgb\\((1?[0-9]{1,2}|2[0-5][0-5]),[ ]*(1?[0-9]{1,2}|2[0-5][0-5]),[ ]*(1?[0-9]{1,2}|2[0-5][0-5])\\)$", options: NSRegularExpression.Options())
        let rgbaColorRegularExpression = try! NSRegularExpression(pattern: "^rgba\\((1?[0-9]{1,2}|2[0-5][0-5]),[ ]*(1?[0-9]{1,2}|2[0-5][0-5]),[ ]*(1?[0-9]{1,2}|2[0-5][0-5]),[ ]*(0?\\.\\d+)\\)$", options: NSRegularExpression.Options())

        let stringValue = string as NSString
        if let match = hexColorRegularExpression.firstMatch(in: string, options: [], range: NSMakeRange(0, string.characters.count)) {
            let group = stringValue.substring(with: match.rangeAt(1))

            if let integerValue = Int(group, radix: 16) {
                self = .hex(integerValue)
            }
        }

        var _r: String?
        var _g: String?
        var _b: String?
        var _a: String?

        for regex in [rgbColorRegularExpression, rgbaColorRegularExpression] {
            if let match = regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.characters.count)) {
                _r = stringValue.substring(with: match.rangeAt(1))
                _g = stringValue.substring(with: match.rangeAt(2))
                _b = stringValue.substring(with: match.rangeAt(3))

                if match.numberOfRanges == 5 {
                    _a = stringValue.substring(with: match.rangeAt(4))
                }
            }
        }

        guard let r = _r,
            let g = _g,
            let b = _b,
            let redValue = Int(r),
            let greenValue = Int(g),
            let blueValue = Int(b) else {
                self = .invalid
                return
        }

        if let a = _a, let alpha = Float(a) {
            self = .rgba(redValue, greenValue, blueValue, alpha)
        }
        else {
            self = .rgb(redValue, greenValue, blueValue)
        }
    }

    public init(stringLiteral value: StringLiteralType) {
        self.init(fromString: value)
    }

    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(fromString: value)
    }

    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init(fromString: value)
    }
}

/**
`UIColor` extension.
*/
public extension UIColor {
    /**
     Initialize a `UIColor` object with any number of methods. E.g.
     
     Integer literals:

     ```
     UIColor(0xF00)
     UIColor(0xFF0000)
     UIColor(0xFF0000FF)
     ```
     
     String literals:

     ```
     UIColor("f00")
     UIColor("FF0000")
     UIColor("rgb(255, 0, 0)")
     UIColor("rgba(255, 0, 0, 0.15)")
     ```
     
     Or (preferably), if you want to be a bit more explicit:
     
     ```
     UIColor(.hex(0xF00))
     UIColor(.rgb(255, 0, 0))
     UIColor(.rgba(255, 0, 0, 0.5))
     ```
     
     If a provided value is invalid, the color will be white with an alpha value of 0.
     
     - parameter color: a `ColorRepresentation`
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    convenience init(_ color: ColorRepresentation) {
        switch color {
        case .hex(let value):
            var r: CGFloat!
            var g: CGFloat!
            var b: CGFloat!
            var a: CGFloat!

            value.toRGBA(&r, &g, &b, &a)
            self.init(red: r, green: g, blue: b, alpha: a)

        case .rgb(let r, let g, let b):
            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: 1)

        case .rgba(let r, let g, let b, let a):
            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a))

        case .invalid:
            self.init(white: 0, alpha: 0)
        }
    }
    
    /**
     Lighten a color by a specified ratio.
     
     - parameter ratio: the ratio by which to lighten the color by.
     - returns: A new `UIColor`.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func lighten(_ ratio: CGFloat) -> UIColor {
        var rgba = [CGFloat](repeating: 0, count: 4)
        getRed(&rgba[0], green: &rgba[1], blue: &rgba[2], alpha: &rgba[3])

        let r = Float(min(rgba[0] + ratio, 1))
        let g = Float(min(rgba[1] + ratio, 1))
        let b = Float(min(rgba[2] + ratio, 1))
        let a = Float(min(rgba[3] + ratio, 1))
        return UIColor(colorLiteralRed: r, green: g, blue: b, alpha: a)
    }

    /**
     Darken a color by a specified ratio.
     
     - parameter ratio: the ratio by which to darken the color by.
     
     - returns: A new `UIColor`.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func darken(_ ratio: CGFloat) -> UIColor {
        var rgba = [CGFloat](repeating: 0, count: 4)
        getRed(&rgba[0], green: &rgba[1], blue: &rgba[2], alpha: &rgba[3])

        let r = Float(max(rgba[0] - ratio, 0))
        let g = Float(max(rgba[1] - ratio, 0))
        let b = Float(max(rgba[2] - ratio, 0))
        let a = Float(max(rgba[3] - ratio, 0))
        return UIColor(colorLiteralRed: r, green: g, blue: b, alpha: a)
    }

    /**
     Indicate whether a given color is dark.

     - returns: A `Bool` indicating if the given `UIColor` is dark.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    var isDark: Bool {
        var rgba = [CGFloat](repeating: 0, count: 4)
        
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
        let newR1: Float = (newR * 255 * 299)
        let newG1: Float = (newG * 255 * 587)
        let newB1: Float = (newB * 255 * 114)
        return ((newR1 + newG1 + newB1) / 1000) < 200
    }
}
