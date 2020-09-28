//
//  UserDefaults.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 21/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation

enum UserDefaultsKeys: String {
    case key = "key"
}

protocol UserDefaultsProtocol {
//    var savedDefaultValue: [] { get set }
}

extension UserDefaults: UserDefaultsProtocol {
//    var savedDefaultValue: [] {
//        get {
//            let object = objectForKey(.key) as? [String] ?? []
//            return object.map { savedDefaultValue.init($0) }
//        }
//        set {
//            setObject(value: newValue.map { $0 }, forKey: .key)
//        }
//    }
}

extension UserDefaults {
    fileprivate func setObject(value: Any?, forKey key: UserDefaultsKeys) {
        set(value, forKey: key.rawValue)
    }
    
    fileprivate func objectForKey(_ key: UserDefaultsKeys) -> Any? {
        object(forKey: key.rawValue)
    }
}
