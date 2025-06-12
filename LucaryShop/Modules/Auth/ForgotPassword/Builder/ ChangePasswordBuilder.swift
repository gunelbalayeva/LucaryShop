//
//   ChangePasswordBuilder.swift
//  LucaryShop
//
//  Created by User on 12.06.25.
//

import UIKit

final class ChangePasswordBuilder {
    private let cordinator :ForgotPasswordCoordinator
    
    init(cordinator: ForgotPasswordCoordinator) {
        self.cordinator = cordinator
    }
    
    func build () -> UIViewController {
        let viewmodel = ChangePasswordViewModel(cordinator: cordinator)
        let vc  = ChangePasswordViewController(viewModel: viewmodel, coordinator: cordinator)
        return vc
    }
}
