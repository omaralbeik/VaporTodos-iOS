//
//  AppDelegate.swift
//  VaporTodos
//
//  Created by Omar Albeik on 8/24/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow()

		if AuthCache.isAuthenticated {
			showTodosViewController(animated: false)
		} else {
			showAuthController(animated: false)
		}

		window?.makeKeyAndVisible()

		return true
	}

}

// MARK: - Helpers
extension AppDelegate {

	func showAuthController(animated: Bool = true) {
		window?.switchRootViewController(to: AuthViewController(), animated: animated, options: .transitionFlipFromRight)
	}

	func showTodosViewController(animated: Bool = true) {
		let navController = UINavigationController(rootViewController: TodosViewController())
		window?.switchRootViewController(to: navController, animated: animated, options: .transitionFlipFromLeft)
	}

}
