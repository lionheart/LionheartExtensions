//
//  Any.swift
//  LionheartExtensions
//
//  Created by Daniel Loewenherz on 2/29/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation

public func liftOptionalFromAny(value: Any) -> Any {
    let mirror = Mirror(reflecting: value)
    if mirror.displayStyle != .Optional {
        return value
    }

    if mirror.children.count == 0 {
        return NSNull()
    }

    let (_, some) = mirror.children.first!
    return some
}
