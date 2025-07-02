//
//  ChangePasswordEndpoint.swift
//  LucaryShop
//
//  Created by User on 02.07.25.
//

import Foundation
enum ChangePasswordEndpoint {
    case changePassword(ChangePasswordRequest)

    var path: String {
        return "/users/change-password"
    }

    var method: String {
        return "PUT"
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
        case .changePassword(let request):
            return try? JSONEncoder().encode(request)
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
