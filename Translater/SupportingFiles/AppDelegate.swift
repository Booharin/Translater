//
//  AppDelegate.swift
//  Translater
//
//  Created by Booharin on 17.03.2020.
//  Copyright © 2020 Umbrella. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: ApplicationCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        coordinator = ApplicationCoordinator()
        coordinator?.start()
        
        return true
    }
}

