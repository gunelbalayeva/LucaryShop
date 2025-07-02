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
    private var orderService:OrderService
    var coordinator: UsersRegisterCoordinato?
    
    init(parentCoordinator: Coordinator? = nil,
         navigationController: UINavigationController,
         profileService: ProfileService,
         authService: AuthService,
         orderService: OrderService) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.profileService = profileService
        self.authService = authService
        self.orderService = orderService
    }
    
    func start(with categoryId: String) {
        
    }
    
    var childCoordinators: [Coordinator] = []

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
    
    func openEditProfile() {
        let editRegisterCoordinator = UsersRegisterCoordinato(
            navigationController: navigationController,
            profileService: profileService,
            authService: authService,
            orderService: orderService)
        
        self.coordinator = editRegisterCoordinator
        editRegisterCoordinator.start()
        print("Edit sehifesi acildi")
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
        print("sertler sehifesi acildi")
    }
}
