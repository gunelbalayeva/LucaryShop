//
//  ProfileEndpoint.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
enum ProfileEndpoint {
    case getMe
    case update(ProfileUpdateRequest)
    var path: String {
        switch self {
        case .getMe:
            return "/users/me"
        case .update:
            return "/users/update" 
        }
    }

    var method: String {
        switch self {
        case .getMe:
            return "GET"
        case .update:
            return "PUT"
        }
    }

    var headers: [String: String] {
        var headers = ["Content-Type": "application/json"]
        if let token = KeychainManager.shared.getToken() {
            headers["Authorization"] = "Bearer \(token)"
            print("Profile tokeb",token)
        }
        return headers
    }

    var body: Data? {
        switch self {
        case .update(let request):
            return try? JSONEncoder().encode(request)
        default:
            return nil
        }
    }

    var request: APIRequest {
        APIRequest(
            url: URL(string: "https://api.lucaryservice.com\(path)")!,
            method: method,
            headers: headers,
            body: body
        )
    }
}

