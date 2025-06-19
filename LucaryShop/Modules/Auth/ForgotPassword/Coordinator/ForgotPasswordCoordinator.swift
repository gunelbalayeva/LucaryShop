//
//  ForgotPasswordCoordinator.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//
import UIKit
enum ForgotPasswordStep {
    case verifyOTP
    case changePassword
}
final class ForgotPasswordCoordinator {
    
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    private let authService: AuthService
    private let verificationId: String
    
    init(parentCoordinator: AppCoordinator? = nil,
         navigationController: UINavigationController,
         authService: AuthService, verificationId: String) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.authService = authService
        self.verificationId = verificationId
    }
    
    func start() {
        let vc = ForgotPasswordBuilder(cordinator: self, authService: authService).build()
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func navigate(to step: ForgotPasswordStep) {
        switch step {
        case .verifyOTP:
            let vc = VerifyOTPBuilder(cordinator: self, authService: authService, verificationId:verificationId).build()
            navigationController.pushViewController(vc, animated: true)
        case .changePassword:
            let vc = ChangePasswordBuilder(cordinator: self, authService: authService).build()
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func finish() {
        parentCoordinator?.didFinishForgotPasswordFlow()
    }
    
    func navigateToVerifyOTP(with verificationId: String) {
        let vc = VerifyOTPBuilder(cordinator: self,
                                  authService: authService,
                                  verificationId: verificationId).build()
        navigationController.pushViewController(vc, animated: true)
    }
}
