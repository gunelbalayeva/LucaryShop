//
//  ProfileCoordinator.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
import UIKit
final class ProfileCoordinator: Coordinator {
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    private let profileService: ProfileService
    private let authService: AuthService
    var onFinish: (() -> Void)?
    var languageCoordinator:LanguageSelectionCoordinator?
    var orderService:OrderService
    
    init(parentCoordinator: AppCoordinator? = nil, navigationController: UINavigationController, profileService: ProfileService, authService: AuthService, languageCoordinator: LanguageSelectionCoordinator? = nil, orderService: OrderService) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.profileService = profileService
        self.authService = authService
        self.languageCoordinator = languageCoordinator
        self.orderService = orderService
    }
    
    func start() {
        let builder = ProfileBuilder(profileService: profileService,
                                     authService: authService,
                                     coordinator: self)
        let vc = builder.build()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func startAndReturnViewController() -> UIViewController {
        let vc = ProfileBuilder(profileService: profileService,
                                authService: authService,
                                coordinator: self).build()
        return UINavigationController(rootViewController: vc)
    }
    
    
    func finish() {
        onFinish?()
        parentCoordinator?.childDidFinish(self)
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
