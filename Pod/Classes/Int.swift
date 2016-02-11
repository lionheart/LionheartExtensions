//
//  Int.swift
//  Upriise
//
//  Created by Daniel Loewenherz on 11/10/15.
//  Copyright © 2015 Upriise LLC. All rights reserved.
//

import UIKit

public extension Int {
    func scaledToDeviceWidth(baseline: CGFloat) -> CGFloat {
        let screen = UIScreen.mainScreen()
        return (CGRectGetWidth(screen.bounds) / baseline) * (CGFloat)(self)
    }
}