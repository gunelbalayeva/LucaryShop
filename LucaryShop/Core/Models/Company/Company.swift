//
//  Company.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
struct Company: Codable ,Hashable{
    let id: String
    let name: String
    let profileImage: String
    let productCount: Int
}
