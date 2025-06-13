//
//   ChangePasswordBuilder.swift
//  LucaryShop
//
//  Created by User on 12.06.25.
//

import UIKit

final class ChangePasswordBuilder {
    private let cordinator :ForgotPasswordCoordinator
    private let authService: AuthService

    init(cordinator: ForgotPasswordCoordinator, authService: AuthService) {
        self.cordinator = cordinator
        self.authService = authService
    }
    
    func build () -> UIViewController {
        let viewmodel = ChangePasswordViewModel(cordinator: cordinator,authService: authService)
        let vc  = ChangePasswordViewController(viewModel: viewmodel, coordinator: cordinator)
        return vc
    }
}
