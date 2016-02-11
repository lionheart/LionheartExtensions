//
//  String.swift
//  Upriise
//
//  Created by Daniel Loewenherz on 11/13/15.
//  Copyright © 2015 Upriise LLC. All rights reserved.
//

import UIKit

public extension String {
    func range() -> NSRange {
        return NSMakeRange(0, self.characters.count)
    }
}