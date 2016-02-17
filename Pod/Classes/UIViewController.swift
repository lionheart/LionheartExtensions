//
//  UIViewController.swift
//  Pods
//
//  Created by Daniel Loewenherz on 2/16/16.
//
//

import Foundation

extension UIViewController {
    public func topViewController() -> UIViewController? {
        return UIViewController.topViewControllerWithRootViewController(UIApplication.sharedApplication().keyWindow?.rootViewController)
    }

    public class func topViewControllerWithRootViewController(rootViewController: UIViewController?) -> UIViewController? {
        if let rootViewController = rootViewController as? UITabBarController {
            return UIViewController.topViewControllerWithRootViewController(rootViewController.selectedViewController)
        }
        else if let rootViewController = rootViewController as? UINavigationController {
            return UIViewController.topViewControllerWithRootViewController(rootViewController.visibleViewController)
        }
        else if let rootViewController = rootViewController as? UISplitViewController {
            return UIViewController.topViewControllerWithRootViewController(rootViewController.viewControllers[1])
        }
        else if let presentedViewController = rootViewController?.presentedViewController {
            if presentedViewController is UIAlertController {
                return presentedViewController
            }
            else {
                return UIViewController.topViewControllerWithRootViewController(presentedViewController)
            }
        }
        else {
            return rootViewController
        }
    }
}