//
//  NSIndexPath.swift
//  Pods
//
//  Created by Daniel Loewenherz on 4/1/16.
//
//

import Foundation

public func ==(tuple: (Int, Int), indexPath: IndexPath) -> Bool {
    return (indexPath as NSIndexPath).section == tuple.0 && (indexPath as NSIndexPath).row == tuple.1
}

public func ==(indexPath: IndexPath, tuple: (Int, Int)) -> Bool {
    return (indexPath as NSIndexPath).section == tuple.0 && (indexPath as NSIndexPath).row == tuple.1
}
