//
//  AccountDetailsViewController.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 27/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import UIKit

final class AccountDetailsViewController: UIViewController {

    @IBOutlet private weak var accountNameLabel: UILabel!
    @IBOutlet private weak var planValueLabel: UILabel!
    @IBOutlet private weak var moneyboxValueLabel: UILabel!
    @IBOutlet private weak var addButton: UIButton!
    
    var viewModel: AccountDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        title = "Individual account"
        
        addButton.layer.masksToBounds = true
        addButton.layer.cornerRadius = 8
        accountNameLabel.text = viewModel.accountName
    }
    
    private func setupBindings() {
        viewModel.moneyBoxAmount.bindAndFire { [weak self] (moneyBoxAmount) in
            print("New amount: \(moneyBoxAmount)")
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.moneyboxValueLabel.text = "Moneybox: £\(moneyBoxAmount)"
            }
        }
        
        viewModel.paymentAmount.bindAndFire { [weak self] (amount) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.addButton.setTitle("Add £\(amount)", for: .normal)
            }
        }
        
        viewModel.error.bindAndFire { [weak self] (error) in
            guard let error = error else { return }
            let alertData = AlertData(title: "Payment error",
                                      message: error.localizedDescription,
                                      acceptButtonTitle: "") { (_) in }
            DispatchQueue.main.async {
                self?.showAlert(data: alertData)
            }
        }
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        viewModel.postOneOffPayment(amount: 10)
    }
}

extension AccountDetailsViewController: AlertPresentable { }
