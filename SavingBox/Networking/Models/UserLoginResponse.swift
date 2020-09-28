//
//  User.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 27/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation

struct UserLoginResponse: Codable {
    let user: User
    let session: UserSession
    
    private enum CodingKeys: String, CodingKey {
        case user = "User"
        case session = "Session"
    }
}

struct User: Codable {
    let id: String
    let firstName: String
    let lastName: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "UserId"
        case firstName = "FirstName"
        case lastName = "LastName"
    }
}

struct UserSession: Codable {
    let id: String
    let bearerToken: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "ExternalSessionId"
        case bearerToken = "BearerToken"
    }
}
