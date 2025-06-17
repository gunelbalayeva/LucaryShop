//
//  RegisterViewModel.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit
enum AppRegisterError: Error {
    case invalidInput
    case invalidEmail
    case invalidPassword
    case invalidCredentials
    case networkError
    case unknown

    var userMessage: String {
        switch self {
        case .invalidInput:
            return "Please fill in all fields"
        case .invalidEmail:
            return "Enter a valid email address (for example: name@example.com)"
        case .invalidPassword:
            return "The password must be at least 6 characters long and contain both letters and numbers"
        case .invalidCredentials:
            return "Username not found or password incorrect"
        case .networkError:
            return "A network error occurred"
        case .unknown:
            return "An unknown error occurred."
        }
    }
}
final class RegisterViewModel {
    
    private let cordinator :RegisterCoordinator
    private let authService: AuthService
    
    init(cordinator: RegisterCoordinator, authService: AuthService) {
        self.cordinator = cordinator
        self.authService = authService
    }
    
    func register(name: String, surname: String, email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let request = Register.RegisterRequest(name: name, surname: surname, email: email, password: password)
        authService.register(request: request) {  result in
            completion(result)
        }
    }
    func goToHome(){
        cordinator.registerCompleted()
    }
}
