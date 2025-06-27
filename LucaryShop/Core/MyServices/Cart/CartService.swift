//
//  CartService.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//
import Foundation
final class CartService {
    private let networkService: NetworkService

    init(networkService: NetworkService = URLSessionNetworkService()) {
        self.networkService = networkService
    }

    func getCart(completion: @escaping (Result<CartResponse, Error>) -> Void) {
        networkService.request(CartEndpoint.get.request, completion: completion)
    }

    func addToCart(productId: String, quantity: Int = 1, completion: @escaping (Result<CartResponse, Error>) -> Void) {
        networkService.request(CartEndpoint.update(productId: productId, quantity: quantity).request, completion: completion)
    }

    func removeFromCart(productId: String, completion: @escaping (Result<CartResponse, Error>) -> Void) {
        networkService.request(CartEndpoint.remove(productId: productId).request, completion: completion)
    }

    func confirmCart(completion: @escaping (Result<CartResponse, Error>) -> Void) {
        networkService.request(CartEndpoint.confirm.request, completion: completion)
    }
}
