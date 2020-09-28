//
//  OneOffPaymentResponse.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 28/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation

struct OneOffPaymentResponse: Codable {
    let moneybox: Double
    
    private enum CodingKeys: String, CodingKey {
        case moneybox = "Moneybox"
    }
}
