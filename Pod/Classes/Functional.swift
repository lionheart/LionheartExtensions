//
//  Functional.swift
//  Pods
//
//  Created by Daniel Loewenherz on 3/9/16.
//
//

import Foundation

public func truthy(item: Any?) -> Bool {
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
            return item == true
        }
    }

    return true
}

public func all(elements: [Any?], test: (Any? -> Bool) = truthy) -> Bool {
    for element in elements {
        if !test(element) {
            return false
        }
    }

    return true
}

public func any(elements: [Any?], test: (Any? -> Bool) = truthy) -> Bool {
    for element in elements {
        if test(element) {
            return true
        }
    }

    return false
}