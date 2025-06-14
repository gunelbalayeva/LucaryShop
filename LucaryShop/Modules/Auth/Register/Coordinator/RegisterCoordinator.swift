//
//  RegisterCoordinator.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class RegisterCoordinator {
    
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
        let vc = RegisterBuilder(cordinator: self, authService: authService).build()
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func registerCompleted() {
        onFinish?()
    }
}
