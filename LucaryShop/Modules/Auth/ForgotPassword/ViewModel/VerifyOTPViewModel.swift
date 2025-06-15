//
//  VerifyOTPViewModel.swift
//  LucaryShop
//
//  Created by User on 12.06.25.
//

import Foundation
final class VerifyOTPViewModel{
    private let cordinator :ForgotPasswordCoordinator
    private let authService: AuthService
    let verificationId: String
   
    init(cordinator: ForgotPasswordCoordinator, authService: AuthService, verificationId: String) {
        self.cordinator = cordinator
        self.authService = authService
        self.verificationId = verificationId
    }
    
    func verifyOTP(code: String, verificationId: String, completion: @escaping (Bool) -> Void) {
        let request = OTPVerification.OTPVerifyRequest(verificationId: verificationId, otp: code)
        authService.verifyOTP(request: request) { result in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                print("OTP verification failed: \(error.localizedDescription)")
                completion(false)
            }
        }
    }


}
