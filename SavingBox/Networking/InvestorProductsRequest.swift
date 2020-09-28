//
//  InvestorProductsRequest.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 28/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation

struct InvestorProductsRequest: Request {
    var method: HTTPMethod = .get
    var path: String = "/investorproducts"
    var queryItems: [URLQueryItem] = []
    var headers: [String : String] = {
        ["AppId": "8cb2237d0679ca88db6464",
        "Content-Type": "application/json",
        "appVersion": "7.10.0",
        "apiVersion": "3.0.0"]
    }()
    
    init(token: String) {
        self.headers.updateValue("Bearer \(token)", forKey: "Authorization")
    }
}
