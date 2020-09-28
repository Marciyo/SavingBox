//
//  KeychainService.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 28/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation
import KeychainSwift

protocol KeychainServiceProtocol {
    var bearerToken: String? { get set }
}

final class KeychainService: KeychainServiceProtocol {
    private enum Keys: String {
        case bearerToken = "BearerToken"
    }
    private let keychain = KeychainSwift()
    
    var bearerToken: String? {
        get {
            keychain.get(Keys.bearerToken.rawValue)
        }
        set {
            if let value = newValue {
                keychain.set(value, forKey: Keys.bearerToken.rawValue)
            } else {
                keychain.delete(Keys.bearerToken.rawValue)
            }
        }
    }
}
