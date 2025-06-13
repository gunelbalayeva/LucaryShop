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
    
    init(cordinator: ForgotPasswordCoordinator, authService: AuthService) {
        self.cordinator = cordinator
        self.authService = authService
    }
    
    func build () -> UIViewController {
        let viewmodel = VerifyOTPViewModel(cordinator: cordinator, authService: authService)
        let vc  = VerifyOTPViewController(viewModel: viewmodel, coordinator: cordinator)
        return vc
    }
}

