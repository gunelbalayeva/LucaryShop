//
//  ForgetPasswordBuilder.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class ForgotPasswordBuilder {
    private let cordinator :ForgotPasswordCoordinator
    private let authService: AuthService

    init(cordinator: ForgotPasswordCoordinator, authService: AuthService) {
        self.cordinator = cordinator
        self.authService = authService
    }
    
    func build () -> UIViewController {
        let viewmodel = ForgotPasswordViewModel(cordinator: cordinator, authService: authService)
        let vc  = ForgotPasswordViewController(viewModel: viewmodel, coordinator: cordinator, authService: authService)
        return vc
    }
}
