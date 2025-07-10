//
//  CartService.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//
import Foundation
final class CartService {
    private let networkService: NetworkService
    static let cartDidChangeNotification = Notification.Name("CartDidChange")
    
    init(networkService: NetworkService = URLSessionNetworkService()) {
        self.networkService = networkService
    }
    
    func getCart(completion: @escaping (Result<CartResponse, Error>) -> Void) {
        networkService.request(CartEndpoint.get.request, completion: completion)
    }
    
    func addToCart(productId: String, quantity: Int = 1, completion: @escaping (Result<CartResponse, Error>) -> Void) {
        networkService.request(CartEndpoint.update(productId: productId, quantity: quantity).request) { result in
            completion(result)
            if case .success = result {
                NotificationCenter.default.post(
                    name: Self.cartDidChangeNotification,
                    object: nil,
                    userInfo: ["productId": productId, "quantity": quantity]
                )
            }
        }
    }
    
    func removeFromCart(productId: String, completion: @escaping (Result<CartResponse, Error>) -> Void) {
        networkService.request(CartEndpoint.remove(productId: productId).request, completion: completion)
    }
    
    func confirmCart(completion: @escaping (Result<CartResponse, Error>) -> Void) {
        networkService.request(CartEndpoint.confirm.request) { [] result in
            completion(result)
            if case .success = result {
                NotificationCenter.default.post(
                    name: Self.cartDidChangeNotification,
                    object: nil,
                    userInfo: ["cleared": true]
                )
            }
        }
    }
}
