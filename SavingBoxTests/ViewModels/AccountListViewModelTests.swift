//
//  AccountListViewModelTests.swift
//  SavingBoxTests
//
//  Created by Marcel Mierzejewski on 28/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import XCTest
@testable import SavingBox

class AccountListViewModelTests: XCTestCase {

    var apiClient: APIClientMock!
    var keychainService: KeychainServiceProtocol!
    var viewModel: AccountListViewModel!
    
    override func setUp() {
        apiClient = APIClientMock()
        keychainService = KeychainServiceMock()
        let dependencies = AppDependency(networkSession: apiClient,
                                         keychainService: keychainService)
        viewModel = AccountListViewModel(user: makeMockUser(), dependencies: dependencies)
        super.setUp()
    }
    
    override func tearDown() {
        apiClient = nil
        viewModel = nil
        keychainService = nil
        super.tearDown()
    }
    
    func test_init_ViewModel() throws {
        XCTAssertEqual(viewModel.welcomeText, "Hello Marcel Mierzejewski")
    }
    
    func test_ViewModel_GetInvestorProductsSuccess() throws {
        apiClient.data = getExampleResponseData()
        apiClient.error = nil
        
        XCTAssertNil(viewModel.investorProductsResponse.value)
        XCTAssertNil(keychainService.bearerToken)
        
        viewModel.getInvestorProducts()
        
        XCTAssertNil(viewModel.investorProductsResponse.value,
                     "Call shouldn't be made when bearer token is nil")
        
        keychainService.bearerToken = "token"
        
        viewModel.getInvestorProducts()
        
        guard let response = viewModel.investorProductsResponse.value else {
            XCTFail("Value should be present")
            return
        }
        XCTAssertEqual(response.totalEarnings, 8.55)
        XCTAssertEqual(response.productResponses[0].id, 8043)
        XCTAssertEqual(response.productResponses[0].product.name, "Stocks & Shares ISA")
    }
    
    func test_ViewModel_GetInvestorProductsFailure() throws {
        apiClient.data = nil
        apiClient.error = NetworkError.network(.none)
        keychainService.bearerToken = "token"

        viewModel.getInvestorProducts()
        
        XCTAssertNil(viewModel.investorProductsResponse.value)
        XCTAssertNotNil(keychainService.bearerToken)
        XCTAssertNotNil(viewModel.error.value)
    }
}

extension AccountListViewModelTests {
    fileprivate func getExampleResponseData() -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "InvestorProductsResponse",
                                   withExtension: "json") else {
            XCTFail("Missing file: InvestorProductsResponse.json")
            return nil
        }
        return try? Data(contentsOf: url)
    }
    
    fileprivate func makeMockUser() -> User {
        User(id: "1234", firstName: "Marcel", lastName: "Mierzejewski")
    }
}
