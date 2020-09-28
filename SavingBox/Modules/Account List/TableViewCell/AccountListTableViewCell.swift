//
//  AccountListTableViewCell.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 27/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import UIKit

final class AccountListTableViewCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var accountNameLabel: UILabel!
    @IBOutlet private weak var planValueLabel: UILabel!
    @IBOutlet private weak var moneyboxLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if #available(iOS 13.0, *) {
            containerView.backgroundColor = .secondarySystemBackground
        } else {
            containerView.layer.borderColor = UIColor.lightGray.cgColor
            containerView.layer.borderWidth = 2
        }

        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
    }
    
    func setup(with productResponse: ProductResponse) {
        accountNameLabel.text = productResponse.product.name
        planValueLabel.text = "Plan Value: £\(productResponse.planValue)"
        moneyboxLabel.text = "Moneybox: £\(productResponse.moneybox)"
    }
}

extension AccountListTableViewCell: NibReusableView { }
