//
//  RegisterViewModel.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class RegisterViewModel {
    
    private let cordinator :RegisterCoordinator
    private let authService: AuthService

    init(cordinator: RegisterCoordinator, authService: AuthService) {
        self.cordinator = cordinator
        self.authService = authService
    }
}
