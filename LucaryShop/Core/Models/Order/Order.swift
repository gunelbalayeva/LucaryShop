//
//  Order.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
struct Order: Decodable {
    let date: String
    let status: String
    let totalPrice: Double
    let products: [CartItem]
}

struct OrdersResponse: Decodable {
    let orders: [Order]
}
