//
//  LoginViewModelTests.swift
//  SavingBoxTests
//
//  Created by Marcel Mierzejewski on 28/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import XCTest
@testable import SavingBox

class LoginViewModelTests: XCTestCase {

    var apiClient: APIClientMock!
    var keychainService: KeychainServiceProtocol!
    var viewModel: LoginViewModel!
    
    override func setUp() {
        apiClient = APIClientMock()
        keychainService = KeychainServiceMock()
        let dependencies = AppDependency(networkSession: apiClient,
                                         keychainService: keychainService)
        
        viewModel = LoginViewModel(dependencies: dependencies)
        super.setUp()
    }
    
    override func tearDown() {
        apiClient = nil
        viewModel = nil
        keychainService = nil
        super.tearDown()
    }

    func test_ViewModel_LoginSuccess() throws {
        apiClient.data = getExampleResponseData()
        apiClient.error = nil
        
        XCTAssertNil(viewModel.currentUser.value)
        XCTAssertNil(keychainService.bearerToken)
        
        viewModel.login(email: "email@wp.pl", password: "password")
        
        XCTAssertNil(viewModel.error.value)
        XCTAssertEqual(viewModel.currentUser.value?.id,
                       "c634381a-7f93-43ff-a21d-cb4506ee5c17")
        XCTAssertEqual(keychainService.bearerToken,
                       "pWLOHE9qASFxh9eoP3f6w3Mvoxgpb0GATe4ENEbfvnU=")
    }
    
    func test_ViewModel_LoginFailure() throws {
        apiClient.data = nil
        apiClient.error = NetworkError.network(.none)

        XCTAssertNil(viewModel.currentUser.value)

        viewModel.login(email: "email@wp.pl", password: "password")

        XCTAssertNil(viewModel.currentUser.value)
        XCTAssertNil(keychainService.bearerToken)
        XCTAssertNotNil(viewModel.error.value)
    }
}

extension LoginViewModelTests {
    fileprivate func getExampleResponseData() -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "UserLoginResponse",
                                   withExtension: "json") else {
            XCTFail("Missing file: UserLoginResponse.json")
            return nil
        }
        return try? Data(contentsOf: url)
    }
}
