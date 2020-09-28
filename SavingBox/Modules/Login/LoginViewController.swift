//
//  LoginViewController.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 27/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import UIKit

protocol LoginCoordinatorDelegate: class {
    func didSuccesfullyLogin(_ viewController: UIViewController, withUser user: User)
}

final class LoginViewController: UIViewController {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    var viewModel: LoginViewModel!
    weak var coordinator: LoginCoordinatorDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        title = "Login"
        
        emailTextField.text = "test+ios@moneyboxapp.com"
        passwordTextField.text = "P455word12"
        passwordTextField.isSecureTextEntry = true
    }
    
    private func setupBindings() {
        viewModel.currentUser.bindAndFire { [weak self] (user) in
            guard let user = user else { return }
            print("Obtained user: \(user)")
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.coordinator?.didSuccesfullyLogin(self, withUser: user)
            }
        }
        
        viewModel.error.bindAndFire { [weak self] (error) in
            guard let error = error else { return }
            let alertData = AlertData(title: "Login error",
                                      message: error.localizedDescription,
                                      acceptButtonTitle: "") { (_) in }
            DispatchQueue.main.async {
                self?.showAlert(data: alertData)
            }
        }
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        viewModel.login(email: emailTextField.text!, password: passwordTextField.text!)
    }
}

extension LoginViewController: AlertPresentable { }
