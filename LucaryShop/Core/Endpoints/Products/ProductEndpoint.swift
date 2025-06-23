//
//  ProductEndpoint.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
import Foundation

enum ProductEndpoint {
    case getAll(page: Int, size: Int)
    case getById(String)
    case getByCategory(Int)

    var path: String {
        switch self {
        case .getAll:
            return "/products"
        case .getById(let id):
            return "/products/\(id)"
        case .getByCategory:
            return "/products/category"
        }
    }

    var method: String {
        return "GET"
    }

    var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .getAll(let page, let size):
            return [
                URLQueryItem(name: "pageNumber", value: "\(page)"),
                URLQueryItem(name: "pageSize", value: "\(size)")
            ]
        case .getByCategory(let categoryId):
            return [
                URLQueryItem(name: "categoryId", value: "\(categoryId)")
            ]
        case .getById:
            return nil
        }
    }

    var url: URL {
        var components = URLComponents(string: "https://e-commerce-app-150649679863.europe-west1.run.app\(path)")!
        components.queryItems = queryItems
        return components.url!
    }
}
