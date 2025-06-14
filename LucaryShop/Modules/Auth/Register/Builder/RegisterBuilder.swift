//
//  RegisterBuilder.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class RegisterBuilder {
    private let cordinator :RegisterCoordinator
    private let authService: AuthService
    
    init(cordinator: RegisterCoordinator, authService: AuthService) {
        self.cordinator = cordinator
        self.authService = authService
    }
    
    func build () -> UIViewController {
        let viewmodel = RegisterViewModel(cordinator: cordinator, authService: authService)
        let vc  = RegisterViewController(viewModel: viewmodel, coordinator: cordinator)
        return vc
    }
}
