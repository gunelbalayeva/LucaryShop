//
//  LoginViewModel.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
final class LoginViewModel {
    private let coordinator: LoginCoordinator
    private let authService: AuthService
    
    init(coordinator: LoginCoordinator, authService: AuthService) {
        self.coordinator = coordinator
        self.authService = authService
    }
    
    func login(email: String, password: String) {
        let request = Login.LoginRequest(email: email, password: password)
        authService.login(request: request) { [weak self] result in
            
        }
    }
}
