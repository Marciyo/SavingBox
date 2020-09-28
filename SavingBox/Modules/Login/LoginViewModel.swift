//
//  LoginViewModel.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 27/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation

final class LoginViewModel {
    typealias Dependencies = HasNetworkService & HasKeychainService
    
    private let apiClient: APIClient
    private var keychainService: KeychainService
    
    let currentUser = Dynamic<User?>(nil)
    let error = Dynamic<Error?>(nil)
    
    init(dependencies: Dependencies) {
        apiClient = APIClient(session: dependencies.networkSession)
        keychainService = dependencies.keychainService
    }
    
    func login(email: String, password: String) {
        let request = UserLoginRequest(email: email, password: password)
        apiClient.load(request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                do  {
                    let response = try JSONDecoder().decode(UserLoginResponse.self, from: data)
                    self.currentUser.value = response.user
                    self.keychainService.bearerToken = response.session.bearerToken
                } catch {
                    self.error.value = error
                    assertionFailure(error.localizedDescription)
                }
               
            case let .failure(error):
                self.error.value = error
                assertionFailure(error.localizedDescription)
            }
        }
    }
}
