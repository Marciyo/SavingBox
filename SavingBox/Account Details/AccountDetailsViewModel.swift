//
//  AccountDetailsViewModel.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 27/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation

final class AccountDetailsViewModel {
    typealias Dependencies = HasNetworkService & HasKeychainService
    
    private let apiClient: APIClient
    private var keychainService: KeychainService
    private let productResponse: ProductResponse
    
    let paymentAmount = Dynamic<Double>(10)
    let error = Dynamic<Error?>(nil)
    let moneyBoxAmount: Dynamic<Double>
    
    var accountName: String {
        productResponse.product.name
    }
    
    var planValue: String {
        "Plan Value: \(productResponse.planValue)"
    }
    
    init(product: ProductResponse, dependencies: Dependencies) {
        productResponse = product
        apiClient = APIClient(session: dependencies.networkSession)
        keychainService = dependencies.keychainService
        moneyBoxAmount = Dynamic<Double>(product.moneybox)
    }
    
    func postOneOffPayment(amount: Double) {
        guard let token = keychainService.bearerToken else {
            assertionFailure("User should have token at this stage")
            return
        }
        let request = OneOffPaymentRequest(token: token, amount: amount,
                                           productId: productResponse.id)
        apiClient.load(request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                do  {
                    let response = try JSONDecoder().decode(OneOffPaymentResponse.self,
                                                            from: data)
                    self.moneyBoxAmount.value = response.moneybox
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
