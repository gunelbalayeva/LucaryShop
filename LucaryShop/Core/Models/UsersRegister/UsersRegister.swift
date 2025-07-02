//
//  UsersRegister.swift
//  LucaryShop
//
//  Created by User on 02.07.25.
//

import Foundation
struct RegisterRequest: Codable {
    let name: String
    let surname: String
    let email: String
    let password: String
}

struct RegisterResponse: Codable {
    let jwt: String
}
