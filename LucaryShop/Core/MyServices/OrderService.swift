//
//  OrderService.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
final class OrderService {
    private let networkService: NetworkService

    init(networkService: NetworkService = URLSessionNetworkService()) {
        self.networkService = networkService
    }

    func getOrders(completion: @escaping (Result<[Order], Error>) -> Void) {
        networkService.request(OrderEndpoint.getOrders.request, completion: completion)
    }
}
