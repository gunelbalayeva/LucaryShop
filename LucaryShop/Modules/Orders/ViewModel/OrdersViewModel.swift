//
//  OrdersViewModel.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
import UIKit

final class OrdersViewModel{
    private weak var coordinator:OrderCoordinator?
    let orderService: OrderService
    @Published var orders: [Order] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(coordinator: OrderCoordinator? = nil, orderService: OrderService) {
        self.coordinator = coordinator
        self.orderService = orderService
    }
    


//        func selectOrder(_ order: Order) {
//            coordinator?.navigateToOrderDetail(order: order)
//        }
}
