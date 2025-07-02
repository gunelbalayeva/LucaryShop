//
//  UsersRegisterBuilder.swift
//  LucaryShop
//
//  Created by User on 02.07.25.
//

import Foundation
import UIKit
final class UsersRegisterBuilder {
    private let authService: AuthService
    private let profileService: ProfileService
    private var coordinator: UsersRegisterCoordinato
    
    init(authService: AuthService, 
         profileService: ProfileService,
         coordinator: UsersRegisterCoordinato) {
        self.authService = authService
        self.profileService = profileService
        self.coordinator = coordinator
    }
    
    func build () -> UIViewController {
        let viewmodel = UsersRegisterViewModel(authService: authService,
                                               profileService: profileService,
                                               coordinator: coordinator)
        let vc  = UsersRegisterViewController(usersViewModel: viewmodel)
        return vc
    }
}
