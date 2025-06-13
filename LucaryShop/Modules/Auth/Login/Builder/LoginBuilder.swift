//
//  LoginBuilder.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class LoginBuilder {
    private let cordinator :LoginCoordinator
    private let authService: AuthService
    
    init(cordinator: LoginCoordinator, authService: AuthService) {
        self.cordinator = cordinator
        self.authService = authService
    }
   
    func build () -> UIViewController {
        let viewmodel = LoginViewModel(coordinator: cordinator, authService: authService)
        let vc  = LoginViewController(viewModel: viewmodel, coordinator: cordinator)
        return vc
    }
}
