//
//  Int.swift
//  Upriise
//
//  Created by Daniel Loewenherz on 11/10/15.
//  Copyright © 2015 Upriise LLC. All rights reserved.
//

import UIKit

public extension Int {
    /**
     Scale a value proportionally to the current screen width. Useful for making designed sizes look proportionally similar on all devices.
     
     For instance, let's say a certain button was meant to take up 30px of an iPhone 6s screen, but you'd like the width to scale proportionally to an iPhone 5s.
     
     ```
     >>> 30.scaledToDeviceWidth(baseWidth: 375)
     25.6
     ```
     
     - parameter baseWidth: The base width for the provided value.
     - returns: A `Float` that represents the proportionally sized value.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
    */
    func scaledToDeviceWidth(baseWidth: CGFloat) -> CGFloat {
        let screen = UIScreen.mainScreen()
        return (CGRectGetWidth(screen.bounds) / baseWidth) * (CGFloat)(self)
    }
}