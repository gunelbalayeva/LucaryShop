//
//  UsersRegisterCoordinator.swift
//  LucaryShop
//
//  Created by User on 02.07.25.
//

import Foundation
import UIKit
final class UsersRegisterCoordinato:Coordinator{
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    private let profileService: ProfileService
    private let authService: AuthService
    var orderService:OrderService
    var profileCoordinator:ProfileCoordinator?
    
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
    
    func start() {
        let builder = UsersRegisterBuilder(authService: authService,
                                           profileService: profileService,
                                           coordinator: self)
        let vc = builder.build()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func start(with categoryId: String) {
        
    }
    
    func goToProfileScreen() {
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController,
                                                    profileService: profileService,
                                                    authService: authService,
                                                    orderService: orderService)
        self.profileCoordinator = profileCoordinator
        profileCoordinator.start()
        print("Profile sehifesi acildi")
    }
}
