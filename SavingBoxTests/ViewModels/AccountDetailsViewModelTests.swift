//
//  AccountDetailsViewModelTests.swift
//  SavingBoxTests
//
//  Created by Marcel Mierzejewski on 28/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import XCTest
@testable import SavingBox

class AccountDetailsViewModelTests: XCTestCase {
    
    var apiClient: APIClientMock!
    var keychainService: KeychainServiceProtocol!
    var viewModel: AccountDetailsViewModel!
    
    override func setUp() {
        apiClient = APIClientMock()
        keychainService = KeychainServiceMock()
        let dependencies = AppDependency(networkSession: apiClient,
                                         keychainService: keychainService)
        
        viewModel = AccountDetailsViewModel(product: makeMockProductResponse(),
                                            dependencies: dependencies)
        super.setUp()
    }
    
    override func tearDown() {
        apiClient = nil
        viewModel = nil
        keychainService = nil
        super.tearDown()
    }

    func test_init_ViewModel() throws {
        XCTAssertEqual(viewModel.paymentAmount.value, 10)
        XCTAssertNil(viewModel.error.value)
        XCTAssertEqual(viewModel.moneyBoxAmount.value, 100)
        XCTAssertEqual(viewModel.accountName, "name")
        XCTAssertEqual(viewModel.planValue, "Plan Value: £123.0")
    }
    
    func test_ViewModel_PostOneOffPayment() throws {
        apiClient.data = getExampleResponseData()
        apiClient.error = nil
        keychainService.bearerToken = "token"

        XCTAssertEqual(viewModel.moneyBoxAmount.value, 100)
        
        viewModel.postOneOffPayment(amount: 10)
        
        XCTAssertEqual(viewModel.moneyBoxAmount.value, 110)
        XCTAssertNil(viewModel.error.value)
    }
    
    func test_ViewModel_GetInvestorProductsFailure() throws {
        apiClient.data = nil
        apiClient.error = NetworkError.network(.none)
        keychainService.bearerToken = "token"
        
        viewModel.postOneOffPayment(amount: 10)
        
        XCTAssertNotNil(keychainService.bearerToken)
        XCTAssertNotNil(viewModel.error.value)
    }
}

extension AccountDetailsViewModelTests {
    fileprivate func makeMockProductResponse() -> ProductResponse {
        ProductResponse(id: 1, planValue: 123, moneybox: 100,
                        product: Product(name: "name",
                                         categoryType: "Investment"))
    }
    
    fileprivate func getExampleResponseData() -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "OneOffPaymentsResponse",
                                   withExtension: "json") else {
            XCTFail("Missing file: OneOffPaymentsResponse.json")
            return nil
        }
        return try? Data(contentsOf: url)
    }
}
