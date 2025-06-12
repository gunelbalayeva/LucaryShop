//
//  RegisterBuilder.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class RegisterBuilder {
    private let cordinator :RegisterCoordinator
        
    init(cordinator: RegisterCoordinator) {
        self.cordinator = cordinator
    }
        func build () -> UIViewController {
            let viewmodel = RegisterViewModel(cordinator: cordinator)
            let vc  = RegisterViewController(viewModel: viewmodel, coordinator: cordinator)
            return vc
        }
}
