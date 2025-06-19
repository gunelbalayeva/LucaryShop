//
//  OrderCoordinator.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import UIKit

final class OrderCoordinator {
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    let orderService:OrderService
    
    init(parentCoordinator: AppCoordinator? = nil, navigationController: UINavigationController, orderService: OrderService) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.orderService = orderService
    }
}
