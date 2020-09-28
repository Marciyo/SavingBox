//
//  UserLoginRequest.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 27/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation

fileprivate struct UserLoginBody: Codable {
    let email: String
    let password: String
    let idfa: String = "Identifer for Advertisers"
    
    private enum CodingKeys: String, CodingKey {
        case email = "Email"
        case password = "Password"
        case idfa = "Idfa"
    }
}

struct UserLoginRequest: Request {
    var method: HTTPMethod = .post
    var path: String = "/users/login"
    var queryItems: [URLQueryItem] = []
    var body: Data?
    
    init(email: String, password: String) {
        let requestBody = UserLoginBody(email: email, password: password)
        do {
            body = try JSONEncoder().encode(requestBody)
        } catch {
            assertionFailure(error.localizedDescription)
            body = nil
        }
    }
}
