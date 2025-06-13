//
//  SendOTPViewViewModel.swift
//  LucaryShop
//
//  Created by User on 12.06.25.
//

import UIKit

final class SendOTPViewViewModel{
    private let cordinator :ForgotPasswordCoordinator
    private let authService: AuthService
    
    init(cordinator: ForgotPasswordCoordinator, authService: AuthService) {
        self.cordinator = cordinator
        self.authService = authService
    }
}
