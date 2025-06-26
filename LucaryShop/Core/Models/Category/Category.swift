//
//  Category.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
struct Category: Codable {
    let id: String
    let name: String
    let imgUrl: String
}

struct CategoryWithProductsResponse: Codable {
    let name: String
    let products: [Product]
}

