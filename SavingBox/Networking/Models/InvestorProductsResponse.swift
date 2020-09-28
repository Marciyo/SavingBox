//
//  InvestorProductsResponse.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 28/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation

struct InvestorProductsResponse: Codable {
    let totalEarnings: Double
    let productResponses: [ProductResponse]
    
    private enum CodingKeys: String, CodingKey {
        case totalEarnings = "TotalEarnings"
        case productResponses = "ProductResponses"
    }
}

struct ProductResponse: Codable {
    let id: Int
    let planValue: Double
    let moneybox: Double
    let product: Product
    
    private enum CodingKeys: String, CodingKey {
        case id = "Id"
        case planValue = "PlanValue"
        case moneybox = "Moneybox"
        case product = "Product"
    }
}

struct Product: Codable {
    let name: String
    let categoryType: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "FriendlyName"
        case categoryType = "CategoryType"
    }
}
