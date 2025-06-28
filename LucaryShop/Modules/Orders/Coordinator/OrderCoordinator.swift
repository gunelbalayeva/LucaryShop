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
    let orderService: OrderService
    var onFinish: (() -> Void)?

    init(parentCoordinator: AppCoordinator? = nil, navigationController: UINavigationController, orderService: OrderService) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.orderService = orderService
    }
    
    func start() {
        let builder = OrdersBuilder(coordinator: self,
                                    orderService: orderService)
        let vc = builder.build()
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    func startAndReturnViewController() -> UIViewController {
        let vc = OrdersBuilder(coordinator: self,
                               orderService: orderService).build()
        return UINavigationController(rootViewController: vc)
    }
    
    
    func finish() {
        onFinish?()
    }
}
