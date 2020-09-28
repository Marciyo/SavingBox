//
//  APIClientMock.swift
//  SavingBox
//
//  Created by Marcel Mierzejewski on 28/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation
@testable import SavingBox

class APIClientMock: NetworkSession {
    var data: Data?
    var error: Error?

    func load(_ request: Request, handler: @escaping (Data?, Error?) -> Void) {
        handler(data, error)
    }
}
