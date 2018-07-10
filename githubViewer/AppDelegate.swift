//
//  AppDelegate.swift
//  githubViewer
//
//  Created by Francis Beauchamp on 2018-07-09.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame:UIScreen.main.bounds)
        guard let window = window else { return false }
        window.makeKeyAndVisible()
        window.backgroundColor = UIColor.white
        window.rootViewController = makeSplitViewController()
        
        UINavigationBar.appearance().barTintColor = UIColor.charcoal
        UINavigationBar.appearance().isOpaque = true
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

        if !Github.authenticated {
            window.rootViewController?.present(LoginViewController(), animated: false, completion: nil)
        }
        
        return true
    }

    private func makeSplitViewController() -> UISplitViewController {
        let splitViewController =  UISplitViewController()
        let rootViewController = RepoListViewController()
        let detailViewController = RepoDetailViewController(repo: nil, branches: [])
        let rootNavigationController = UINavigationController(rootViewController: rootViewController)
        let detailNavigationController = UINavigationController(rootViewController: detailViewController)
        splitViewController.viewControllers = [rootNavigationController, detailNavigationController]
        return splitViewController
    }
}
