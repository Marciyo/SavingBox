//
//  Coordinator.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 27/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    func add(childCoordinator: Coordinator) {
        childCoordinators.append(childCoordinator)
    }

    func remove(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
}

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
        let vc = ViewController()
//        vc.viewModel = vm(dependencies: dependencies)
        rootViewController = UINavigationController(rootViewController: vc)
        window.rootViewController = rootViewController
    }
}
