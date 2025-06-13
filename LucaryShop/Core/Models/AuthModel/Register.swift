//
//  Register.swift
//  LucaryShop
//
//  Created by User on 13.06.25.
//

import Foundation
struct Register {
    struct RegisterRequest: Encodable {
        let name: String
        let surname: String
        let email: String
        let password: String
    }
}
