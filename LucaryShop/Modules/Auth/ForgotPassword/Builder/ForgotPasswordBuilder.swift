//
//  ForgetPasswordBuilder.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class ForgotPasswordBuilder {
    private let cordinator :ForgotPasswordCoordinator
    
    init(cordinator: ForgotPasswordCoordinator) {
        self.cordinator = cordinator
    }
    
    func build () -> UIViewController {
        let viewmodel = ForgotPasswordViewModel(cordinator: cordinator)
        let vc  = ForgotPasswordViewController(viewModel: viewmodel, coordinator: cordinator)
        return vc
    }
}
