//
//  Request.swift
//  Valuto
//
//  Created by Marcel Mierzejewski on 15/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
}

protocol Request {
    var scheme: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var host: String { get }
    var queryItems: [URLQueryItem] { get }
    var headers: [String: String] { get }
    var body: Data? { get }
}

extension Request {
    var method: HTTPMethod { return .get }
    var scheme: String { return "https" }
    var headers: [String: String] { return [:] }
    var host: String { return "https://api-test02.moneyboxapp.com/" }
    var body: Data? { return nil }
}

extension Request {
    func build() -> URLRequest? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure("Invalid url components")
        }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue
        request.httpBody = body
        return request
    }
}
