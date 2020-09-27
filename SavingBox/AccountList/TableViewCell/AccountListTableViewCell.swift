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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 2
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
    }
}

extension AccountListTableViewCell: NibReusableView { }
