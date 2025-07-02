//
//  ProfileService.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
final class ProfileService {
    private let networkService: NetworkService
    
    init(networkService: NetworkService = URLSessionNetworkService()) {
        self.networkService = networkService
    }
    
    
    func getProfile(completion: @escaping (Result<User, Error>) -> Void) {
        networkService.request(ProfileEndpoint.getMe.request, completion: completion)
    }
    
    func updateProfile(request: ProfileUpdateRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        networkService.request(ProfileEndpoint.update(request).request) { (result: Result<EmptyResponse, Error>) in
            completion(result.map { _ in () })
        }
    }
}


