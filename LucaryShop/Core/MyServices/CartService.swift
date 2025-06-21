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

    func getCart(completion: @escaping (Result<[CartItem], Error>) -> Void) {
        networkService.request(CartEndpoint.get.request, completion: completion)
    }

    func addToCart(product: Product, completion: @escaping (Result<Void, Error>) -> Void) {
        networkService.request(CartEndpoint.add(product).request) { (result: Result<EmptyResponse, Error>) in
            completion(result.map { _ in () })
        }
    }

    func removeFromCart(productId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        networkService.request(CartEndpoint.remove(productId).request) { (result: Result<EmptyResponse, Error>) in
            completion(result.map { _ in () })
        }
    }

    func checkout(completion: @escaping (Result<Void, Error>) -> Void) {
        networkService.request(CartEndpoint.checkout.request) { (result: Result<EmptyResponse, Error>) in
            completion(result.map { _ in () })
        }
    }
}
