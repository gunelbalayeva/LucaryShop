//
//  LoginCoordinator.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class LoginCoordinator {
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    private let authService: AuthService
    
    var onFinish: (() -> Void)?
    
    init(parentCoordinator: AppCoordinator? = nil, navigationController: UINavigationController, authService: AuthService, onFinish: ( () -> Void)? = nil) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.authService = authService
        self.onFinish = onFinish
    }
    
    func start() {
        let vc = LoginBuilder(cordinator: self, authService: authService).build()
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func finish() {
        onFinish?()
    }
    
    func showHomePage() {
        let homeVC = HomeViewController()
        navigationController.pushViewController(homeVC, animated: true)
    }
    
    
    func showForgotPasswordPage() {
        let forgotCoordinator = ForgotPasswordCoordinator(
            parentCoordinator: parentCoordinator,
            navigationController: navigationController,
            authService: authService
        )
        forgotCoordinator.start()
    }
}
