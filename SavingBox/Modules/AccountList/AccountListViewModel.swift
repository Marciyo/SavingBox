//
//  AccountListViewModel.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 27/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation

final class AccountListViewModel {
    typealias Dependencies = HasNetworkService & HasKeychainService

    private let apiClient: APIClient
    private var keychainService: KeychainService
    
    var investorProductsResponse = Dynamic<InvestorProductsResponse?>(nil)
    let error = Dynamic<Error?>(nil)

    private let currentUser: User
    
    public var welcomeText: String {
        "Hello \(currentUser.firstName) \(currentUser.lastName)"
    }
    
    init(user: User, dependencies: Dependencies) {
        currentUser = user
        apiClient = APIClient(session: dependencies.networkSession)
        keychainService = dependencies.keychainService
    }
    
    func productResponse(for indexPath: IndexPath) -> ProductResponse {
        investorProductsResponse.value!.productResponses[indexPath.item]
    }
    
    func getInvestorProducts() {
        guard let token = keychainService.bearerToken else {
            assertionFailure("User should have token at this stage")
            return
        }
        let request = InvestorProductsRequest(token: token)
        apiClient.load(request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                do  {
                    let response = try JSONDecoder().decode(InvestorProductsResponse.self, from: data)
                    self.investorProductsResponse.value = response
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
