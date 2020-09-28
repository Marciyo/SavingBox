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
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    var viewModel: LoginViewModel!
    weak var coordinator: LoginCoordinatorDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Login"
        
        emailTextField.text = "test+ios@moneyboxapp.com"
        passwordTextField.text = "P455word12"
        passwordTextField.isSecureTextEntry = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginButtonAction(self)
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        viewModel.login(email: emailTextField.text!, password: passwordTextField.text!)
//        coordinator?.didSuccesfullyLogin(self)
    }
}
