//
//  ForgetPasswordViewModel.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class ForgotPasswordViewModel{
    private let cordinator :ForgotPasswordCoordinator
    private let authService: AuthService

    init(cordinator: ForgotPasswordCoordinator, authService: AuthService) {
        self.cordinator = cordinator
        self.authService = authService
    }
    
    func sendOTP(email: String, completion: @escaping (Bool) -> Void) {
        let request = SendEmail.SendEmailRequest(email: email)
        authService.sendEmail(request: request) { result in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                completion(false)
            }
        }
    }

}
