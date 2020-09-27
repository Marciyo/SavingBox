//
//  AccountListViewModel.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 27/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation

final class AccountListViewModel {
    typealias Dependencies = HasUserDefaultsProtocol & HasNetworkManager
    
    private let apiClient: APIClient
    private var userDefaults: UserDefaultsProtocol
    
    var accountList: [String] = ["First", "Second", "Third", "Fourth"]
    
    init(dependencies: Dependencies) {
        apiClient = APIClient(session: dependencies.networkSession)
        userDefaults = dependencies.userDefaults
    }
}
