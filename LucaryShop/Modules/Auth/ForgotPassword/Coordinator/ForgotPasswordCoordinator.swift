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
    private let authService: AuthService

    init(parentCoordinator: AppCoordinator? = nil, navigationController: UINavigationController, authService: AuthService) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.authService = authService
    }
    
    func start() {
        let vc = ForgotPasswordBuilder(cordinator: self, authService: authService).build()
        navigationController.setViewControllers([vc], animated: true)
    }
    func navigate(to step: ForgotPasswordStep) {
        switch step {
        case .sendOTP:
            let vc = SendOTPViewBuilder(cordinator: self, authService: authService).build()
            navigationController.pushViewController(vc, animated: true)
            
        case .verifyOTP:
            let vc = VerifyOTPBuilder(cordinator: self, authService: authService).build()
            navigationController.pushViewController(vc, animated: true)
            
        case .changePassword:
            let vc = ChangePasswordBuilder(cordinator: self, authService: authService).build()
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func finish() {
        parentCoordinator?.startAuthFlow(.login)
    }

}
