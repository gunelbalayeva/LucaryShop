//
//  ProductDetailCoordinator.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class ProductDetailCoordinator :Coordinator{
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let productService: ProductService
    let favoritesService: FavoritesService
    let cartService: CartService
    let orderService:OrderService
    var cartCoordinator: CartCoordinator?
    var onFinish: (() -> Void)?
    
    init(parentCoordinator: Coordinator? = nil,
         navigationController: UINavigationController,
         productService: ProductService,
         favoritesService: FavoritesService,
         cartService: CartService,
         orderService: OrderService) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.productService = productService
        self.favoritesService = favoritesService
        self.cartService = cartService
        self.orderService = orderService
    }
    
    func start() {
        
    }
    
    func start(with productId: String) {
        let viewModel = ProductDetailViewModel(productId: productId,
                                               productService: productService,
                                               favoritesService: favoritesService,
                                               cartService: cartService,
                                               coordinator: self)
        let vc = ProductDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
        print(" Navigation stack count: \(navigationController.viewControllers.count)")
    }

    func goToCart() {
        let cartCoordinator = CartCoordinator(
            parentCoordinator: parentCoordinator,
            navigationController: navigationController,
            cartService: cartService,
            orderService: orderService
        )
        self.cartCoordinator = cartCoordinator
        cartCoordinator.start()
    }


       func finish() {
           onFinish?()
    }
}
