//
//  LoginBuilder.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class LoginBuilder {
    private let cordinator :LoginCoordinator
    
    init(cordinator: LoginCoordinator) {
        self.cordinator = cordinator
    }
    func build () -> UIViewController {
        let viewmodel = LoginViewModel(cordinator: cordinator)
        let vc  = LoginViewController(viewModel: viewmodel, coordinator: cordinator)
        return vc
    }
}
