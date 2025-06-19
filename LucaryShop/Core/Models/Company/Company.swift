//
//  Company.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
struct Company: Codable {
    let id: Int
    let name: String
    let logoUrl: String?
    let description: String?
}

struct CompanyRequest: Codable {
    let name: String
    let logoUrl: String?
    let description: String?
}
