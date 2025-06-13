//
//  SendEmail.swift
//  LucaryShop
//
//  Created by User on 13.06.25.
//

import Foundation
struct SendEmail {
    struct SendEmailRequest: Encodable {
        let email: String
    }
    struct VerificationIdResponse: Decodable {
        let verificationId: String
    }
}
