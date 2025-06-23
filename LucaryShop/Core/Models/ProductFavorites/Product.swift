//
//  Product.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
struct Product: Codable {
    let id: String
    let name: String
    let description: String?
    let price: Double
    let imgUrl: String?       
    let favorite: Bool
}
