//
//  OneOffPaymentRequest.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 28/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation

fileprivate struct OneOffPaymentBody: Codable {
    let amount: Double
    let productId: Int
    
    private enum CodingKeys: String, CodingKey {
        case amount = "Amount"
        case productId = "InvestorProductId"
    }
}

struct OneOffPaymentRequest: Request {
    var method: HTTPMethod = .post
    var path: String = "/oneoffpayments"
    var queryItems: [URLQueryItem] = []
    var headers: [String : String] = {
        ["AppId": "8cb2237d0679ca88db6464",
        "Content-Type": "application/json",
        "appVersion": "7.10.0",
        "apiVersion": "3.0.0"]
    }()
    var body: Data?
    
    init(token: String, amount: Double, productId: Int) {
        self.headers.updateValue("Bearer \(token)", forKey: "Authorization")
        
        let requestBody = OneOffPaymentBody(amount: amount, productId: productId)
        do {
            body = try JSONEncoder().encode(requestBody)
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
}
