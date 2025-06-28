//
//  SecurePaymentCoordinator.swift
//  LucaryShop
//
//  Created by User on 28.06.25.
//

import Foundation
import UIKit
final class SecurePaymentCoordinator {
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    let cartService: CartService
    let orderService: OrderService
    var onFinish: (() -> Void)?
    
    init(parentCoordinator: AppCoordinator? = nil, navigationController: UINavigationController, cartService: CartService, orderService: OrderService) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.cartService = cartService
        self.orderService = orderService
    }
    
    func start() {
        let builder = SecurePaymentBuilder(cartService: cartService,
                                  coordinator: self)
        let vc = builder.build()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToOrder(){
        let orderCoordinator = OrderCoordinator(parentCoordinator: parentCoordinator,
                                                navigationController: navigationController,
                                                orderService: orderService)
        
        orderCoordinator.start()
        
    }
    
    func finish() {
        onFinish?()
    }
}
