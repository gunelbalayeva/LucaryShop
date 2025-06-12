//
//  ForgotPasswordCoordinator.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

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
}
