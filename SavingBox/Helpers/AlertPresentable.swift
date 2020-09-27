//
//  Alerts.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 21/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import UIKit

protocol AlertPresentable {
    func showAlert(data: AlertData)
}

struct AlertData {
    let title: String
    let message: String
    let acceptButtonTitle: String
    let completionHandler: ((UIAlertAction) -> Void)?
}

extension AlertPresentable where Self: UIViewController {
    func showAlert(data: AlertData) {
        let alertController = UIAlertController(title: data.title, message: data.message, preferredStyle: .alert)
        if !data.acceptButtonTitle.isEmpty {
            alertController.addAction(UIAlertAction(title: data.acceptButtonTitle, style: .default, handler: data.completionHandler))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        } else {
            alertController.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        }
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
