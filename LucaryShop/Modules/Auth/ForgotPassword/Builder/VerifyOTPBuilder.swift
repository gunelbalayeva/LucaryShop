//
//  VerifyOTPViewBuilder.swift
//  LucaryShop
//
//  Created by User on 12.06.25.
//


import UIKit

final class VerifyOTPBuilder {
    private let cordinator :ForgotPasswordCoordinator
    private let authService: AuthService
    private let verificationId: String 
    
    init(cordinator: ForgotPasswordCoordinator, authService: AuthService, verificationId: String) {
        self.cordinator = cordinator
        self.authService = authService
        self.verificationId = verificationId
    }
    
    func build () -> UIViewController {
        let viewmodel = VerifyOTPViewModel(cordinator: cordinator, authService: authService, verificationId: verificationId)
        let vc  = VerifyOTPViewController(viewModel: viewmodel, coordinator: cordinator)
        return vc
    }
}

