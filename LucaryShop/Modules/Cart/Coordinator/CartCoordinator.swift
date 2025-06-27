//
//  CartCoordinator.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//
import UIKit
final class CartCoordinator{
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    let cartService: CartService
    let orderService: OrderService?
    var onFinish: (() -> Void)?
    
    init(parentCoordinator: AppCoordinator? = nil, navigationController: UINavigationController, cartService: CartService, orderService: OrderService?, onFinish: ( () -> Void)? = nil) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.cartService = cartService
        self.orderService = orderService
        self.onFinish = onFinish
    }
    
    
    func start() {
        let builder = CartBuilder(cartService: cartService,
                                  coordinator: self)
        let vc = builder.build()
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    
    func finish() {
        onFinish?()
    }
    
    
    func navigateToOrders() {
        guard let orderService = orderService else { return }
        let orderCoordinator = OrderCoordinator(parentCoordinator: parentCoordinator,
                                                navigationController: navigationController,
                                                orderService: orderService)
        orderCoordinator.start()
    }
    
    
    
    func dismiss() {
        navigationController.popViewController(animated: true)
        finish()
    }
}
