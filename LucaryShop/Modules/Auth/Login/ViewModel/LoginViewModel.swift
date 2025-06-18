//
//  LoginViewModel.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
enum AppLoginError: Error {
    case invalidCredentials
    case networkError
    case unknown
    
    var userMessage: String {
        switch self {
        case .invalidCredentials:
            return "No such user found or the password is incorrect"
        case .networkError:
            return "A network error occurred.."
        case .unknown:
            return "An unknown error occurred"
        }
    }
}

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
                    completion(.success(()))
                    self.coordinator.finish()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    completion(.failure(AppLoginError.invalidCredentials))
                }
            }
        }
    }
    
    func forgotPasswordTapped() {
        coordinator.showForgotPasswordPage()
    }
}
