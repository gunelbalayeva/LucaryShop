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
    
    init(parentCoordinator: AppCoordinator? = nil, navigationController: UINavigationController, profileService: ProfileService, authService: AuthService) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.profileService = profileService
        self.authService = authService
    }
    
    func start() {
        let viewModel = ProfileViewModel(profileService: profileService, authService: authService, coordinator: self)
        let viewController = ProfileViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
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
}
