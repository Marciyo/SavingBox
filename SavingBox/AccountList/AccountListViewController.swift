//
//  AccountListViewController.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 27/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import UIKit

protocol AccountListCoordinatorDelegate: class {
    func willOpenDetails(_ viewController: UIViewController, for product: ProductResponse)
    func didLogout(_ viewController: UIViewController)
}

final class AccountListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var welcomeLabel: UILabel!
    
    var viewModel: AccountListViewModel!
    weak var coordinator: AccountListCoordinatorDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        addNavigationBarItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getInvestorProducts()
    }
    
    private func setupUI() {
        title = "User accounts"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountListTableViewCell.self)
        
        welcomeLabel.text = viewModel.welcomeText
    }
    
    private func setupBindings() {
        viewModel.investorProductsResponse.bindAndFire { [weak self] (response) in
            guard let response = response else { return }
            print("Obtained response: \(response)")
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.error.bindAndFire { [weak self] (error) in
            guard let error = error else { return }
            let alertData = AlertData(title: "Login error",
                                      message: error.localizedDescription,
                                      acceptButtonTitle: "") { (_) in }
            self?.showAlert(data: alertData)
        }
    }
    
    deinit {
        print("deinited account list")
    }
    
    private func addNavigationBarItems() {
           if #available(iOS 13.0, *) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(logoutButtonAction))
           } else {
               navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .done,
                                                                   target: self, action: #selector(logoutButtonAction))
           }
       }
    
    @objc private func logoutButtonAction() {
        let alertData = AlertData(title: "Would you like to log out?", message: "", acceptButtonTitle: "Yes") { [weak self] (_) in
            guard let self = self else { return }
            self.coordinator?.didLogout(self)
        }
        showAlert(data: alertData)
    }
}

extension AccountListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.investorProductsResponse.value?.productResponses.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AccountListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setup(with: viewModel.productResponse(for: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension AccountListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.willOpenDetails(self, for: viewModel.productResponse(for: indexPath))
    }
}

extension AccountListViewController: AlertPresentable { }
