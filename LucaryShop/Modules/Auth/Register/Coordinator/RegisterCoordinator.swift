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
    
    init(navigationController: UINavigationController, parentCoordinator: AppCoordinator) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let vc = RegisterBuilder(cordinator: self).build()
        navigationController.setViewControllers([vc], animated: true)
    }
}
