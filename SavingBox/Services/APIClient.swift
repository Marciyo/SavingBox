//
//  APIClient.swift
//  Valuto
//
//  Created by Marcel Mierzejewski on 15/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation

protocol NetworkSession {
    func load(_ request: Request, handler: @escaping (Data?, Error?) -> Void)
}

enum NetworkError: Error {
    case invalidRequest
    case network(Error?)
}

extension URLSession: NetworkSession {
    func load(_ request: Request, handler: @escaping (Data?, Error?) -> Void) {
        guard let request = request.build() else {
            handler(nil, NetworkError.invalidRequest)
            return
        }

        let task = dataTask(with: request) { (data, _, error) in
            handler(data, error)
        }
        task.resume()
    }
}

final class APIClient {
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }

    func load(_ request: Request, handler: @escaping (Result<Data, NetworkError>) -> Void) {
        session.load(request) { data, error in
            let result = data.map(Result.success) ?? .failure(NetworkError.network(error))
            handler(result)
        }
    }
}
