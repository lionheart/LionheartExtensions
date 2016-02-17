//
//  UIViewController.swift
//  Pods
//
//  Created by Daniel Loewenherz on 2/16/16.
//
//

import Foundation

public extension UIViewController {
    func topViewController() -> UIViewController? {
        return UIViewController.topViewControllerWithRootViewController(UIApplication.sharedApplication().keyWindow?.rootViewController)
    }

    class func topViewControllerWithRootViewController(rootViewController: UIViewController?) -> UIViewController? {
        if let tabBarController = rootViewController as? UITabBarController {
            return UIViewController.topViewControllerWithRootViewController(tabBarController.selectedViewController)
        }
        else if let navigationController = rootViewController as? UINavigationController {
            return UIViewController.topViewControllerWithRootViewController(navigationController.visibleViewController)
        }
        else if let splitViewController = rootViewController as? UISplitViewController {
            return UIViewController.topViewControllerWithRootViewController(splitViewController.viewControllers[1])
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