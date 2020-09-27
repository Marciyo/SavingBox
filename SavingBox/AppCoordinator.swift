//
//  AppCoordinator.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 27/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    var rootViewController: UINavigationController
    var childCoordinators: [Coordinator]
    var dependencies: AppDependency!

    private let window: UIWindow
    
    init(window: UIWindow, dependencies: AppDependency) {
        rootViewController = UINavigationController()
        childCoordinators = []
        self.window = window
        self.dependencies = dependencies
    }
    
    func start() {
        startLogin()
    }

    private func startLogin() {
        let vc = LoginViewController()
        vc.viewModel = LoginViewModel(dependencies: dependencies)
        rootViewController = UINavigationController(rootViewController: vc)
        window.rootViewController = rootViewController
    }
    
    private func startAccountList() {
        let vc = AccountListViewController()
        vc.viewModel = AccountListViewModel(dependencies: dependencies)
        rootViewController = UINavigationController(rootViewController: vc)
        window.rootViewController = rootViewController
    }
    
    private func startAccountDetails(for account: String) {
        let vc = AccountDetailsViewController()
        vc.viewModel = AccountDetailsViewModel(dependencies: dependencies)
        rootViewController = UINavigationController(rootViewController: vc)
        window.rootViewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
