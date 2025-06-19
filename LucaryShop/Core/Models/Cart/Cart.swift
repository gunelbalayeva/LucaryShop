//
//  Cart.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
struct CartItem: Codable {
    let productId: Int
    let name: String
    let quantity: Int
    let price: Double
    let imageUrl: String
}

struct CheckoutRequest: Codable {
    let address: String
    let paymentMethod: String
}
