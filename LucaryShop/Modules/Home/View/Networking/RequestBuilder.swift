//
//  RequestBuilder.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
struct APIRequest {
    let url: URL
    let method: String
    var headers: [String: String]
    let body: Data?
    var authToken: String? = nil
}


final class RequestBuilder {
    static func build(_ request: APIRequest) -> URLRequest {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method
        urlRequest.timeoutInterval = 30

        var allHeaders = request.headers
        if let token = request.authToken {
            allHeaders["Authorization"] = "Bearer \(token)"
        }
        urlRequest.allHTTPHeaderFields = allHeaders
        urlRequest.httpBody = request.body
        return urlRequest
    }
}
