//
//  LoginViewController.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 27/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import UIKit

protocol LoginCoordinatorDelegate: class {
    func didSuccesfullyLogin(_ viewController: UIViewController)
}

final class LoginViewController: UIViewController {

    var viewModel: LoginViewModel!
    weak var coordinator: LoginCoordinatorDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Login"
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        coordinator?.didSuccesfullyLogin(self)
    }
}
