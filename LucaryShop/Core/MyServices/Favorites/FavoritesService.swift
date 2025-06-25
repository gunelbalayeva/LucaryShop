//
//  FavoritesService.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
import Combine
final class FavoritesService {
    static let favoritesDidChangeNotification = Notification.Name("FavoritesDidChange")
       
       private let networkService: NetworkService
       let favoritesChangePublisher = PassthroughSubject<(productId: String, isFavorite: Bool), Never>()

       init(networkService: NetworkService = URLSessionNetworkService()) {
           self.networkService = networkService
       }
       
       func getFavorites(completion: @escaping (Result<[Product], Error>) -> Void) {
           networkService.request(FavoritesEndpoint.get.request, completion: completion)
       }
       
       func addFavorite(productId: String, completion: @escaping (Result<Void, Error>) -> Void) {
           networkService.request(FavoritesEndpoint.add(productId).request) { [weak self] (result: Result<EmptyResponse, Error>) in
               completion(result.map { _ in () })
               if case .success = result {
                   self?.favoritesChangePublisher.send((productId: productId, isFavorite: true))
                   NotificationCenter.default.post(
                       name: Self.favoritesDidChangeNotification,
                       object: nil,
                       userInfo: ["productId": productId, "isFavorite": true]
                   )
               }
           }
       }
       
       func removeFavorite(productId: String, completion: @escaping (Result<Void, Error>) -> Void) {
           networkService.request(FavoritesEndpoint.remove(productId).request) { [weak self] (result: Result<EmptyResponse, Error>) in
               completion(result.map { _ in () })
               if case .success = result {
                   self?.favoritesChangePublisher.send((productId: productId, isFavorite: false))
                   NotificationCenter.default.post(
                       name: Self.favoritesDidChangeNotification,
                       object: nil,
                       userInfo: ["productId": productId, "isFavorite": false]
                   )
               }
           }
       }
}
