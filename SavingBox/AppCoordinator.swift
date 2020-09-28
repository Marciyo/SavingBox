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
        vc.coordinator = self
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.prefersLargeTitles = true
        rootViewController = navigationController
        window.rootViewController = rootViewController
    }
    
    private func startAccountList(for user: User) {
        let vc = AccountListViewController()
        vc.viewModel = AccountListViewModel(user: user, dependencies: dependencies)
        vc.coordinator = self
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.prefersLargeTitles = true
        rootViewController = navigationController
        window.rootViewController = rootViewController
    }
    
    private func startAccountDetails(for product: ProductResponse) {
        let vc = AccountDetailsViewController()
        vc.viewModel = AccountDetailsViewModel(product: product, dependencies: dependencies)
        rootViewController.pushViewController(vc, animated: true)
    }
}

extension AppCoordinator: AccountListCoordinatorDelegate {
    func didLogout(_ viewController: UIViewController) {
        clearUserData()
        startLogin()
    }
    
    private func clearUserData() {
        dependencies.keychainService.bearerToken = nil
    }
    
    func willOpenDetails(_ viewController: UIViewController, for product: ProductResponse) {
        startAccountDetails(for: product)
    }
}

extension AppCoordinator: LoginCoordinatorDelegate {
    func didSuccesfullyLogin(_ viewController: UIViewController, withUser user: User) {
        startAccountList(for: user)
    }
}
