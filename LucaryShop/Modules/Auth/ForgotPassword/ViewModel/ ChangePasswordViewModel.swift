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
    
    init(cordinator: ForgotPasswordCoordinator) {
        self.cordinator = cordinator
    }
    
    var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        return $password
            .map { password in
                password.count >= 6
                && password.rangeOfCharacter(from: .decimalDigits) != nil
                && password.rangeOfCharacter(from: .letters) != nil
            }
            .eraseToAnyPublisher()
    }  // abc123
    
    func didSuccessfullyChangePassword() {
        cordinator.finish()
    }
}
