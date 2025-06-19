//
//  CartEndpoint.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
enum CartEndpoint {
    case get
    case add(Product)
    case remove(Int)
    case checkout

    var path: String {
        switch self {
        case .get:
            return "/cart"
        case .add:
            return "/cart"
        case .remove(let id):
            return "/cart/\(id)"
        case .checkout:
            return "/checkout"
        }
    }

    var method: String {
        switch self {
        case .get:
            return "GET"
        case .add, .checkout:
            return "POST"
        case .remove:
            return "DELETE"
        }
    }

    var headers: [String: String] {
        var headers = ["Content-Type": "application/json"]
        if let token = KeychainManager.shared.getToken() {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }

    var body: Data? {
        switch self {
        case .add(let product):
            return try? JSONEncoder().encode(product)
        default:
            return nil
        }
    }

    var request: APIRequest {
        APIRequest(
            url: URL(string: "https://e-commerce-app-150649679863.europe-west1.run.app\(path)")!,
            method: method,
            headers: headers,
            body: body
        )
    }
}
