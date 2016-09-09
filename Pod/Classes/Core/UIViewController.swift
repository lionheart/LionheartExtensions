//
//  Copyright 2016 Lionheart Software LLC
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//

import Foundation

public extension UIViewController {
    /**
     Returns an optional with the top-level `UIViewController`.
     
     - returns: The active `UIViewController`, if it can be found.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func topViewController() -> UIViewController? {
        return UIViewController.topViewControllerWithRootViewController(UIApplication.shared.keyWindow?.rootViewController)
    }

    /**
     Return an optional with the top-level `UIViewController` for the provided `UIViewController`.
     
     - returns: The active `UIViewController`, if it can be found.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    class func topViewControllerWithRootViewController(_ rootViewController: UIViewController?) -> UIViewController? {
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
