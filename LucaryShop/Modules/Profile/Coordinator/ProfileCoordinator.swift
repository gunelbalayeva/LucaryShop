//
//  ProfileCoordinator.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
import UIKit
final class ProfileCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    private let profileService: ProfileService
    private let authService: AuthService
    var onFinish: (() -> Void)?
    var languageCoordinator:LanguageSelectionCoordinator?
    var orderService:OrderService
    
    init(parentCoordinator: Coordinator? = nil, 
         navigationController: UINavigationController,
         profileService: ProfileService,
         authService: AuthService,
         languageCoordinator: LanguageSelectionCoordinator? = nil,
         orderService: OrderService,
         childCoordinators: [Coordinator]) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.profileService = profileService
        self.authService = authService
        self.languageCoordinator = languageCoordinator
        self.orderService = orderService
        self.childCoordinators = childCoordinators
    }
    
    func start(with categoryId: String) {
        
    }
    
    var childCoordinators: [Coordinator]
    
    func start() {
        let builder = ProfileBuilder(profileService: profileService,
                                     authService: authService,
                                     coordinator: self)
        let vc = builder.build()
        navigationController.pushViewController(vc, animated: true)
    }
   
    
    func finish() {
        onFinish?() 
    }

    
    func openEditProfile() { // BUNU YAZMAMISAM
//        let builder = ProfileBuilder(profileService: profileService,
//                                     authService: authService,
//                                     coordinator: self)
//        let vc = builder.build()
//        navigationController.pushViewController(vc, animated: true)
        
    }

    func openLanguageScreen() {
        let languageCoordinator = LanguageSelectionCoordinator(navigationController: navigationController)
        languageCoordinator.startLanguage()
        print("Dil səhifəsi")
    }

    func openOrders() {
        let coordinator = OrderCoordinator(navigationController: navigationController,
                                       orderService: orderService)
        coordinator.start()
        print("Sifarişlərim")
    }

    func openAboutUs() {
        let coordinator = AboutCoordinator(navigationController: navigationController)
        coordinator.start()
        print("Haqqımızda")
    }

    func openTerms() {
        let coordinator = TermsCoordinator(navigationController: navigationController)
        coordinator.start()
        print("Şərtlər")
    }
}
