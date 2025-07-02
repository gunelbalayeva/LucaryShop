//
//  UsersRegisterViewModel.swift
//  LucaryShop
//
//  Created by User on 02.07.25.
//

import Foundation
final class UsersRegisterViewModel {
    private let authService: AuthService
    private let profileService: ProfileService
    var coordinator: UsersRegisterCoordinato?
    var user: User?
    
    init(authService: AuthService,
         profileService: ProfileService,
         coordinator: UsersRegisterCoordinato? = nil) {
        self.authService = authService
        self.profileService = profileService
        self.coordinator = coordinator
    }
    
    func fetchUser(completion: @escaping (User?) -> Void) {
        profileService.getProfile { result in
            switch result {
            case .success(let user):
                self.user = user
                completion(user)
            case .failure:
                completion(nil)
            }
        }
    }
    
    func updateProfile(name: String, surname: String,
                       email: String,
                       completion: @escaping (Result<Void, Error>) -> Void) {
        let request = ProfileUpdateRequest(name: name, surname: surname, email: email)
        profileService.updateProfile(request: request, completion: completion)
    }
}
