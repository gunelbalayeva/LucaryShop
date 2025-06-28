//
//  OrdersBuilder.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class OrdersBuilder {
    private var coordinator:OrderCoordinator
    let orderService: OrderService
    
    init(coordinator: OrderCoordinator, orderService: OrderService) {
        self.coordinator = coordinator
        self.orderService = orderService
    }
    
    func build () -> UIViewController {
        let viewmodel = OrdersViewModel(coordinator: coordinator,
                                        orderService: orderService)
        let vc  = OrdersViewController(viewModel: viewmodel)
        return vc
    }
    
    
}
