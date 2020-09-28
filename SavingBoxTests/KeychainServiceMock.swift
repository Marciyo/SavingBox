//
//  KeychainServiceMock.swift
//  SavingBoxTests
//
//  Created by Marcel Mierzejewski on 28/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation
@testable import SavingBox

class KeychainServiceMock: KeychainServiceProtocol {
    var bearerToken: String?
}
