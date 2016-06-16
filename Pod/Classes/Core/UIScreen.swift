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
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func statusBarView() -> UIView {
        let view = snapshotView(afterScreenUpdates: true)
        return view.resizableSnapshotView(from: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height), afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)!
    }
}
