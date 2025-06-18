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
    @Published var hasStartedTyping = false
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
    }
    
    func changePassword(completion: @escaping (Result<Void, Error>) -> Void)  {
        let request = ResetPassword.ResetPasswordRequest(newPassword: password)
        authService.resetPassword(request: request) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    completion(.success(()))
                    self.cordinator.finish()
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func didSuccessfullyChangePassword() {
        cordinator.finish()
    }
}
