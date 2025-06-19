//
//  ProductEndpoint.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
enum ProductEndpoint {
    case getAll
    case getById(Int)
    case getByCategory(Int)

    var path: String {
        switch self {
        case .getAll:
            return "/products"
        case .getById(let id):
            return "/products/\(id)"
        case .getByCategory(let categoryId):
               return "/products?categoryId=\(categoryId)"        }
    }

    var method: String {
        return "GET"
    }

    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }

    var request: APIRequest {
        var allHeaders = headers
        if let token = KeychainManager.shared.getToken() {
            allHeaders["Authorization"] = "Bearer \(token)"
        }

        return APIRequest(
            url: URL(string: "https://e-commerce-app-150649679863.europe-west1.run.app\(path)")!,
            method: method,
            headers: allHeaders,
            body: nil
        )
    }
}
