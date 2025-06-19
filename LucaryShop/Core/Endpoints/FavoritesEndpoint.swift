//
//  FavoritesEndpoint.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
enum FavoritesEndpoint {
    case get
    case add(Int)
    case remove(Int)

    var path: String {
        switch self {
        case .get:
            return "/favorites"
        case .add(let id), .remove(let id):
            return "/favorites/\(id)"
        }
    }

    var method: String {
        switch self {
        case .get:
            return "GET"
        case .add:
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

    var request: APIRequest {
        APIRequest(
            url: URL(string: "https://e-commerce-app-150649679863.europe-west1.run.app\(path)")!,
            method: method,
            headers: headers,
            body: nil
        )
    }
}
