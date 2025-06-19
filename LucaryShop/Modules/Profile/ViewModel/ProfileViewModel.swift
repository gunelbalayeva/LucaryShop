//
//  ProfileViewModel.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
final class ProfileViewModel {
    private let profileService: ProfileService
    private let authService: AuthService
    private weak var coordinator: ProfileCoordinator?
    @Published var user: User?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init(profileService: ProfileService, authService: AuthService, coordinator: ProfileCoordinator? = nil) {
        self.profileService = profileService
        self.authService = authService
        self.coordinator = coordinator
    }
    
    func fetchProfile() {
        isLoading = true
        profileService.getProfile { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let user):
                    self?.user = user
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func logout() {
        authService.logout()
        coordinator?.finish()
    }
}
