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

public extension Int {
    /**
     Scale a value proportionally to the current screen width. Useful for making designed sizes look proportionally similar on all devices.
     
     For instance, let's say a certain button was meant to take up 30px of an iPhone 6s screen, but you'd like the width to scale proportionally to an iPhone SE:
     
     ```
     >>> 30.scaledToDeviceWidth(baseWidth: 375)
     25.6
     ```
     
     - Parameters:
         - baseWidth: The base width for the provided value.
     - Returns: A `CGFloat` that represents the proportionally sized value.
     - Date: February 17, 2016
    */
    func scaledToDeviceWidth(_ baseWidth: CGFloat) -> CGFloat {
        let screen = UIScreen.main
        return (screen.bounds.width / baseWidth) * CGFloat(self)
    }

    /**
     Convert an Int value representing RGBA color components into red, green, blue, and alpha CGFloat representations.
     
     This is useful for converting something like a HEX representation of a color to RGBA. For instance:
     
     ```
     var r: CGFloat!
     var g: CGFloat!
     var b: CGFloat!
     var a: CGFloat!
     0xFF000000.toRGBA(&r, &g, &b, &a)
     // r = 1, g = 0, b = 0, a = 0
     ```

     - Parameters:
         * r: The variable to write the red color value to.
         * g: The variable to write the green color value to.
         * b: The variable to write the blue color value to.
         * a: The variable to write the alpha value to.
     - Date: May 24, 2017
     */
    func toRGBA(_ r: inout CGFloat!, _ g: inout CGFloat!, _ b: inout CGFloat!, _ a: inout CGFloat!) {
        if self > 0xFFFFFF {
            r = CGFloat((self>>24) & 0xFF) / 0xFF
            g = CGFloat((self>>16) & 0xFF) / 0xFF
            b = CGFloat((self>>8) & 0xFF) / 0xFF
            a = CGFloat(self & 0xFF) / 0xFF
        } else if self > 0xFFF {
            r = CGFloat((self>>16) & 0xFF) / 0xFF
            g = CGFloat((self>>8) & 0xFF) / 0xFF
            b = CGFloat(self & 0xFF) / 0xFF
            a = 1
        } else {
            r = CGFloat((self>>8) & 0xF) / 0xF
            g = CGFloat((self>>4) & 0xF) / 0xF
            b = CGFloat(self & 0xF) / 0xF
            a = 1
        }
    }
}
