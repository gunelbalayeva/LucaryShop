//
//  CartEndpoint.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
enum CartEndpoint {
    case get
    case update(productId: String, quantity: Int)
    case remove(productId: String)
    case confirm

    var path: String {
        switch self {
        case .get:
            return "/carts"
        case .update(let id, _):
            return "/carts/update/\(id)"
        case .remove(let id):
            return "/carts/remove/\(id)"
        case .confirm:
            return "/carts/confirm"
        }
    }

    var method: String {
        switch self {
        case .get:
            return "GET"
        case .update, .remove, .confirm:
            return "PUT"
        }
    }

    var headers: [String: String] {
        var headers = ["Content-Type": "application/json"]
        if let token = KeychainManager.shared.getToken() {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .update(_, let quantity):
            return [URLQueryItem(name: "quantity", value: "\(quantity)")]
        default:
            return nil
        }
    }

    var body: Data? {
        return nil 
    }

    var request: APIRequest {
        var components = URLComponents(string: "https://e-commerce-app-150649679863.europe-west1.run.app\(path)")!
        components.queryItems = queryItems
        return APIRequest(
            url: components.url!,
            method: method,
            headers: headers,
            body: body
        )
    }
}
