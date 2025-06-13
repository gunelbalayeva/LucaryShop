//
//  OTPVerification.swift
//  LucaryShop
//
//  Created by User on 13.06.25.
//

import Foundation
struct OTPVerification {
    struct OTPVerifyRequest: Encodable {
        let verificationId: String
        let otp: String
    }
}
