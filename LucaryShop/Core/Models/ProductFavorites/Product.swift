//
//  Product.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation

struct Product: Codable {
    let id: Int
    let name: String
    let price: Double
    let imageUrl: String
    let isFavorite: Bool
    let company: Company?
}

struct ProductDetail: Codable {
    let id: Int
    let name: String
    let description: String
    let price: Double
    let imageUrl: String
    let isFavorite: Bool
}
