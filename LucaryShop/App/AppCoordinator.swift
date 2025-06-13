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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
                navigationController: navigationController,
                parentCoordinator: self)
            loginCoordinator.onFinish = { [weak self] in
                self?.startHomeFlow()
            }
            loginCoordinator.start()
            
        case .register:
            let registerCoordinator = RegisterCoordinator(
                navigationController: navigationController,
                parentCoordinator:self)
            registerCoordinator.onFinish = { [weak self] in
                self?.startHomeFlow()
            }
            registerCoordinator.start()
            
        case .forgotPassword:
            let forgotCoordinator = ForgotPasswordCoordinator(
                navigationController: navigationController,
                parentCoordinator:self)
            forgotCoordinator.start()
        }
    }
    func startHomeFlow() {
//        let mainCoordinator = HomeCoordinator(navigationController: navigationController)
//        mainCoordinator.start()
    }

}
