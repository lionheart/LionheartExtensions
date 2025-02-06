//
//  Main.swift
//  LionheartExtensions
//
//  Created by Dan Loewenherz on 1/2/18.
//

import UIKit

public struct LionheartExtensions {
  static var sharedUIApplication: UIApplication? {
    guard
      let sharedApplication = UIApplication.perform(NSSelectorFromString("sharedApplication"))
        .takeUnretainedValue() as? UIApplication
    else {
      return nil
    }

    return sharedApplication
  }
}
