//
//  UINavigationController+prefferedStatusBarStyle.swift
//  githubViewer
//
//  Created by Francis Beauchamp on 2018-07-11.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var childViewControllerForStatusBarStyle: UIViewController? {
        return visibleViewController
    }
}

extension UISplitViewController {
    open override var childViewControllerForStatusBarStyle: UIViewController? {
        return viewControllers.first
    }
}
