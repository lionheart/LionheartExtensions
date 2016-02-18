//
//  UIScreen.swift
//  Pods
//
//  Created by Daniel Loewenherz on 2/16/16.
//
//

import Foundation

public extension UIScreen {
    /**
     Return a view snapshot containing the status bar.

     - returns: The `UIView` snapshot.
     - author: Dan Loewenherz
     - copyright: 2016
     - date: February 17, 2016
     */
    func snapshotContainingStatusBar() -> UIView {
        let screen = UIScreen.mainScreen()
        let view = UIScreen.mainScreen().snapshotViewAfterScreenUpdates(true)
        return view.resizableSnapshotViewFromRect(CGRect(x: 0, y: 0, width: CGRectGetWidth(screen.bounds), height: 20), afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
    }
}