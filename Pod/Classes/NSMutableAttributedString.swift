//
//  NSMutableAttributedString.swift
//  Upriise
//
//  Created by Daniel Loewenherz on 11/13/15.
//  Copyright © 2015 Upriise LLC. All rights reserved.
//

import UIKit

public extension NSMutableAttributedString {
    func addStringWithAttributes(string: String, attributes: [String: AnyObject]) {
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        self.appendAttributedString(attributedString)
    }
}
