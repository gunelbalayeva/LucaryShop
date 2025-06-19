//
//  FavoritesService.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
final class FavoritesService {
    private let networkService: NetworkService

    init(networkService: NetworkService = URLSessionNetworkService()) {
        self.networkService = networkService
    }

    func getFavorites(completion: @escaping (Result<[Product], Error>) -> Void) {
        networkService.request(FavoritesEndpoint.get.request, completion: completion)
    }

    func addFavorite(productId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        networkService.request(FavoritesEndpoint.add(productId).request) { (result: Result<EmptyResponse, Error>) in
            completion(result.map { _ in () })
        }
    }

    func removeFavorite(productId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        networkService.request(FavoritesEndpoint.remove(productId).request) { (result: Result<EmptyResponse, Error>) in
            completion(result.map { _ in () })
        }
    }
}
