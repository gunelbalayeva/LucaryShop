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
    
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let request = Login.LoginRequest(email: email, password: password)
        authService.login(request: request) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.coordinator.showHomePage()
                    completion(.success(()))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func forgotPasswordTapped() {
        coordinator.showForgotPasswordPage()
    }
}
