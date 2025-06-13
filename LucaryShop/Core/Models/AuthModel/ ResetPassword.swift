//
//   ResetPassword.swift
//  LucaryShop
//
//  Created by User on 13.06.25.
//

import Foundation
struct ResetPassword {
    struct ResetPasswordRequest: Encodable {
        let newPassword: String
    }
}
