//
//  OrdersViewModel.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
import UIKit

final class OrdersViewModel{
    private var coordinator:OrderCoordinator?
    let orderService: OrderService
    @Published var orders: [Order] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(coordinator: OrderCoordinator? = nil, orderService: OrderService) {
        self.coordinator = coordinator
        self.orderService = orderService
    }
    

    func fetchOrders() {
        isLoading = true
        orderService.getOrders { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let orders):
                    print(result)
                    self?.orders = orders
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print(error)
                }
            }
        }
    }
}
