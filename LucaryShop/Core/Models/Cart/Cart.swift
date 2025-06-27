//
//  Cart.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
struct CartItem: Decodable {
    let id: String
    let name: String
    let price: Double
    let imgUrl: String
    let quantity: Int
}

struct CartResponse: Decodable {
    let totalPrice: Double
    let products: [CartItem]
}
