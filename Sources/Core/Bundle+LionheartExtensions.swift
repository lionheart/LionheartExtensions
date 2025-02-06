//
//  Bundle+LionheartExtensions.swift
//  Pods
//
//  Created by Daniel Loewenherz on 8/31/17.
//
//

import Foundation

extension Bundle {
  /// The version string.
  public static var appVersion: String? {
    return main.infoDictionary?["CFBundleShortVersionString"] as? String
  }

  /// The bundle version.
  public static var appBuildNumber: String? {
    return main.infoDictionary?[kCFBundleVersionKey as String] as? String
  }
}
