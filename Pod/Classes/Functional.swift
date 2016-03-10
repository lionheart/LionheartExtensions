//
//  Functional.swift
//  Pods
//
//  Created by Daniel Loewenherz on 3/9/16.
//
//

import Foundation

public protocol Truthy {}
extension Int: Truthy {}
extension String: Truthy {}
extension Bool: Truthy {}

public func truthy(item: AnyObject?) -> Bool {
    if item == nil {
        return false
    }

    if let item = item {
        if let item = item as? String {
            return item.length > 0
        }
        else if let item = item as? Int {
            return item > 0
        }
        else if let item = item as? Bool {
            return item
        }
        else {
            return false
        }
    }

    return true
}

public func all(elements: [AnyObject?], test: (AnyObject? -> Bool) = truthy) -> Bool {
    for element in elements {
        if !test(element) {
            return false
        }
    }

    return true
}

public func any(elements: [AnyObject?], test: (AnyObject? -> Bool) = truthy) -> Bool {
    for element in elements {
        if test(element) {
            return true
        }
    }

    return false
}

public func all<T: Truthy>(elements: [T?], test: (AnyObject? -> Bool) = truthy) -> Bool {
    for element in elements {
        if let element = element as? AnyObject {
            if !test(element) {
                return false
            }
        }
    }

    return true
}

public func any<T: Truthy>(elements: [T?], test: (AnyObject? -> Bool) = truthy) -> Bool {
    for element in elements {
        if let element = element as? AnyObject {
            if test(element) {
                return true
            }
        }
    }

    return false
}