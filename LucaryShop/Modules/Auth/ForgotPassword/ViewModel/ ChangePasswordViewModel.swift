//
//   ChangePasswordViewModel.swift
//  LucaryShop
//
//  Created by User on 12.06.25.
//

import Foundation
import Combine

final class ChangePasswordViewModel {
    
    private let cordinator :ForgotPasswordCoordinator
    @Published var password: String = ""
    private let authService: AuthService
    
    init(cordinator: ForgotPasswordCoordinator, authService: AuthService) {
        self.cordinator = cordinator
        self.authService = authService
    }
    
    var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        return $password
            .map { password in
                password.count >= 6
                && password.rangeOfCharacter(from: .decimalDigits) != nil
                && password.rangeOfCharacter(from: .letters) != nil
            }
            .eraseToAnyPublisher()
    }  // mes: abc123
    
    func changePassword(completion: @escaping (Result<Void, Error>) -> Void) {
        let request = ResetPassword.ResetPasswordRequest(newPassword: password)
        
        authService.resetPassword(request: request) { result in
            completion(result)
        }
    }
    
    func didSuccessfullyChangePassword() {
        cordinator.finish()
    }
}
