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
        
        title = "Individual account"

        addButton.layer.masksToBounds = true
        addButton.layer.cornerRadius = 8
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        print("Add 10£")
    }
}
