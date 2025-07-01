//
//  CategoryEndpoint.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
enum CategoryEndpoint {
    case getAll
    var path: String { "/categories" }
    var method: String { "GET" }
    var headers: [String: String] {
        var headers = ["Accept": "application/json"]
        if let token = KeychainManager.shared.getToken() {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }

    var request: APIRequest {
        APIRequest(
            url: URL(string: "https://e-commerce-app-150649679863.europe-west1.run.app\(path)")!,
            method: method,
            headers: headers,
            body: nil
        )
    }
}
