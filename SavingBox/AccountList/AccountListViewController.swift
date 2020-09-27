//
//  AccountListViewController.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 27/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import UIKit

protocol AccountListCoordinatorDelegate: class {
    func didChooseAccount(_ viewController: UIViewController, accountName: String)
    func didLogout(_ viewController: UIViewController)
}

final class AccountListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: AccountListViewModel!
    weak var coordinator: AccountListCoordinatorDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User accounts"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountListTableViewCell.self)
        
        addNavigationBarItems()
    }
    
    deinit {
        print("deinited")
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
        return viewModel.accountList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AccountListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
//        cell.setup(with: Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension AccountListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.didChooseAccount(self, accountName: "\(indexPath)")
    }
}

extension AccountListViewController: AlertPresentable { }
