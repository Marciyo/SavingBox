//
//  AppDelegate.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 24/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import UIKit

struct AppDependency: HasUserDefaultsProtocol, HasNetworkManager {
    let userDefaults: UserDefaultsProtocol
    let networkSession: NetworkSession
}

protocol HasUserDefaultsProtocol {
    var userDefaults: UserDefaultsProtocol { get }
}

protocol HasNetworkManager {
    var networkSession: NetworkSession { get }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    lazy var dependencies: AppDependency = {
        let userDefaults: UserDefaultsProtocol = UserDefaults.standard
        let apiClient: NetworkSession = URLSession.shared

        return AppDependency(userDefaults: userDefaults, networkSession: apiClient)
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        appCoordinator = AppCoordinator(window: window!, dependencies: dependencies)
        appCoordinator?.start()
        window?.makeKeyAndVisible()
        return true
    }
}
