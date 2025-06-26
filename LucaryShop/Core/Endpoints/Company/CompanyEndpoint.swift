//
//  CompanyEndpoint.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
enum CompanyEndpoint {
    case getAll
    case getById(String)

    var path: String {
        switch self {
        case .getAll:
            return "/companies"
        case .getById(let id):
            return "/companies/\(id)" 
        }
    }

    var method: String {
        switch self {
        case .getAll, .getById:
            return "GET"
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
        return nil
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
