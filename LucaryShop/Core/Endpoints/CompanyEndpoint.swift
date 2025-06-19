//
//  CompanyEndpoint.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
enum CompanyEndpoint {
    case getAll
    case getById(Int)
    case create(CompanyRequest)
    case update(id: Int, CompanyRequest)
    case delete(id: Int)

    var path: String {
        switch self {
        case .getAll:
            return "/companies"
        case .getById(let id),
             .update(let id, _),
             .delete(let id):
            return "/companies/\(id)"
        case .create:
            return "/companies"
        }
    }

    var method: String {
        switch self {
        case .getAll, .getById:
            return "GET"
        case .create:
            return "POST"
        case .update:
            return "PUT"
        case .delete:
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
        case .create(let request),
             .update(_, let request):
            return try? JSONEncoder().encode(request)
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
