//
//  UIDevice.swift
//  Pods
//
//  Created by Daniel Loewenherz on 8/16/16.
//
//

import UIKit

extension UIDevice {
  /// The current device's UUID
  public static var UUIDString: String? {
    return current.identifierForVendor?.uuidString
  }
}
