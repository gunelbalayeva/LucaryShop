//
//  AppCoordinator.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
import UIKit

protocol Coordinator:AnyObject {
    func start()
}

enum AuthFlowType {
    case login
    case register
    case forgotPassword
}

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let authService: AuthService

    init(navigationController: UINavigationController, authService: AuthService) {
        self.navigationController = navigationController
        self.authService = authService
    }
    
    func start() {
        let vc = SplashBuild(cordinator: self).build()
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func goToPermissionsOnboarding() {
        let vc = PermissionsOnboardingBuilder(coordinator: self).build()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToGetStartedOnboarding() {
        let vc = GetStartedOnboardingBuilder(coordinator: self).build()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func startAuthFlow(_ flow: AuthFlowType) {
        switch flow {
        case .login:
            let loginCoordinator = LoginCoordinator(
                parentCoordinator: self, navigationController: navigationController, authService: authService)
            loginCoordinator.onFinish = { [weak self] in
                self?.startHomeFlow()
            }
            loginCoordinator.start()
        case .register:
            let registerCoordinator = RegisterCoordinator(
                parentCoordinator:self, navigationController: navigationController, authService: authService)
            registerCoordinator.onFinish = { [weak self] in
                self?.startHomeFlow()
            }
            registerCoordinator.start()
            
        case .forgotPassword:
            let forgotCoordinator = ForgotPasswordCoordinator(
                parentCoordinator:self, navigationController: navigationController, authService: authService)
            forgotCoordinator.start()
        }
    }
    func startHomeFlow() {
//        let mainCoordinator = HomeCoordinator(navigationController: navigationController)
//        mainCoordinator.start()
    }

}
