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
    
    func register(name: String, surname: String, email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let request = Register.RegisterRequest(name: name, surname: surname, email: email, password: password)
        authService.register(request: request) {  result in
            completion(result)
        }
    }
    
}
