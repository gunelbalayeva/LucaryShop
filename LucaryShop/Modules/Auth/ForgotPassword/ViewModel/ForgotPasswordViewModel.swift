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
}
