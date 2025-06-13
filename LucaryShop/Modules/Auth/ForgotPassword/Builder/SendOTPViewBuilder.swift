//
//  SendOTPViewBuilder.swift
//  LucaryShop
//
//  Created by User on 12.06.25.
//

import UIKit

final class SendOTPViewBuilder {
    private let cordinator :ForgotPasswordCoordinator
    private let authService: AuthService
    
    init(cordinator: ForgotPasswordCoordinator, authService: AuthService) {
        self.cordinator = cordinator
        self.authService = authService
    }
    
    func build () -> UIViewController {
        let viewmodel = SendOTPViewViewModel(cordinator: cordinator, authService: authService)
        let vc  = SendOTPViewController(viewModel: viewmodel, coordinator: cordinator)
        return vc
    }
}
