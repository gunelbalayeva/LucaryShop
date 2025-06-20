//
//  CompanyDetail.swift
//  LucaryShop
//
//  Created by User on 21.06.25.
//

import Foundation
struct CompanyDetail {
    let id: Int
    let name: String
    let description: String
    let products: [Product]

    init(id: Int, name: String, description: String, products: [Product]) {
        self.id = id
        self.name = name
        self.description = description
        self.products = products
    }
}
