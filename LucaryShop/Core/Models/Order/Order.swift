//
//  Order.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
struct Order: Codable {
    let id: Int
    let date: String
    let totalPrice: Double
    let status: String
    let items: [OrderItem]
}

struct OrderItem: Codable {
    let productName: String
    let quantity: Int
    let price: Double
}
