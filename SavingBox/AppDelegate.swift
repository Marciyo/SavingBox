//
//  AppDelegate.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 24/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import UIKit

struct AppDependency: HasNetworkService, HasKeychainService {
    let networkSession: NetworkSession
    var keychainService: KeychainServiceProtocol
}

protocol HasNetworkService {
    var networkSession: NetworkSession { get }
}

protocol HasKeychainService {
    var keychainService: KeychainServiceProtocol { get }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    lazy var dependencies: AppDependency = {
        let apiClient: NetworkSession = URLSession.shared
        let keychainService: KeychainServiceProtocol = KeychainService()
        return AppDependency(networkSession: apiClient, keychainService: keychainService)
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        appCoordinator = AppCoordinator(window: window!, dependencies: dependencies)
        appCoordinator?.start()
        window?.makeKeyAndVisible()
        return true
    }
}
