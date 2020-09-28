//
//  LoginViewModel.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 27/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation

final class LoginViewModel {
    typealias Dependencies = HasUserDefaultsProtocol & HasNetworkManager
    
    private let apiClient: APIClient
    private var userDefaults: UserDefaultsProtocol
    
    init(dependencies: Dependencies) {
        apiClient = APIClient(session: dependencies.networkSession)
        userDefaults = dependencies.userDefaults
    }
    
    func login(email: String, password: String) {
        let request = UserLoginRequest(email: email, password: password)
        apiClient.load(request) { result in
            switch result {
            case let .success(data):
                let decoded = try! JSONDecoder().decode(UserLoginResponse.self, from: data)
                print(decoded)
            case let .failure(error):
                assertionFailure(error.localizedDescription)
            }
        }
    }
}
