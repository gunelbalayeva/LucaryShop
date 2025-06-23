//
//  ProductEndpoint.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
enum ProductEndpoint {
    case getAll(page: Int, size: Int)
    case getById(String)
    case getByCategory(Int)
    case addToFavorites(productId: String)
    case addToCart(productId: String)
    
    var method: String {
        switch self {
        case .getAll, .getById, .getByCategory:
            return "GET"
        case .addToFavorites, .addToCart:
            return "POST"
        }
    }
    
    var path: String {
        switch self {
        case .getAll:
            return "/products"
        case .getById(let id):
            return "/products/\(id)"
        case .getByCategory:
            return "/products"
        case .addToFavorites(let id):
            return "/favorites/\(id)"
        case .addToCart(let id):
            return "/cart/\(id)"
        }
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
        default:
            return nil
        }
    }
    
    var url: URL {
        var components = URLComponents(string: "https://e-commerce-app-150649679863.europe-west1.run.app\(path)")!
        components.queryItems = queryItems
        return components.url!
    }
    
    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }
}
