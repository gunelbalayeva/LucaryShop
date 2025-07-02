//
//  User.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
struct User : Codable {
    let name: String?
    let surname: String?
    let email: String?
}

struct ProfileUpdateRequest: Codable {
    let name: String
    let email: String
    let phone: String?
}

