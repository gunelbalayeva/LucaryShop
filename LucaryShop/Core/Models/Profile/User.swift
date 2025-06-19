//
//  User.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
struct User : Codable {
        let id: Int
        let name: String
        let email: String
        let phone: String?
    }

struct ProfileUpdateRequest: Codable {
    let name: String
    let email: String
    let phone: String?
}

