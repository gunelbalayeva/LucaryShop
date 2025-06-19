//
//  Login.swift
//  LucaryShop
//
//  Created by User on 13.06.25.
//

import Foundation
struct Login {
    struct LoginRequest: Encodable {
        let email: String
        let password: String
    }
    
    struct AuthResponse: Decodable {
        let jwt: String
    }
}
