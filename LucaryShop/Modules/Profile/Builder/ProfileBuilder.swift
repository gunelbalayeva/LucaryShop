//
//  ProfileBuilder.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
import UIKit
final class ProfileBuilder {
    private let profileService: ProfileService
    private let authService: AuthService
    private var coordinator: ProfileCoordinator
    
    init(profileService: ProfileService,
         authService: AuthService,
         coordinator: ProfileCoordinator) {
        self.profileService = profileService
        self.authService = authService
        self.coordinator = coordinator
    }
    
    func build () -> UIViewController {
        let viewmodel = ProfileViewModel(profileService: profileService,
                                         authService: authService,
                                         coordinator: coordinator)
        let vc  = ProfileViewController(viewModel: viewmodel)
        return vc
    }
}
