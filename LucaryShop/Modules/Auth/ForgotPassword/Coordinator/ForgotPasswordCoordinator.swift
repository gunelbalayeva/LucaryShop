//
//  ForgotPasswordCoordinator.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit
enum ForgotPasswordStep {
    case sendOTP
    case verifyOTP
    case changePassword
}

final class ForgotPasswordCoordinator {
    
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, parentCoordinator: AppCoordinator) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    
    func start() {
        let vc = ForgotPasswordBuilder(cordinator: self).build()
        navigationController.setViewControllers([vc], animated: true)
    }
    func navigate(to step: ForgotPasswordStep) {
        switch step {
        case .sendOTP:
            let vc = SendOTPViewBuilder(cordinator: self).build()
            navigationController.pushViewController(vc, animated: true)
            
        case .verifyOTP:
            let vc = VerifyOTPBuilder(cordinator: self).build()
            navigationController.pushViewController(vc, animated: true)
            
        case .changePassword:
            let vc = ChangePasswordBuilder(cordinator: self).build()
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func finish() {
        parentCoordinator?.startAuthFlow(.login)
    }
}
