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
    
}
