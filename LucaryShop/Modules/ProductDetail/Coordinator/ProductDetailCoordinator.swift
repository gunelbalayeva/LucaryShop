//
//  ProductDetailCoordinator.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class ProductDetailCoordinator {
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    let productService: ProductService
    let favoritesService: FavoritesService
    let cartService: CartService
    var onFinish: (() -> Void)?
    
    init(parentCoordinator: AppCoordinator? = nil, navigationController: UINavigationController,
         productService: ProductService, favoritesService: FavoritesService,
         cartService: CartService, onFinish: ( () -> Void)? = nil) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.productService = productService
        self.favoritesService = favoritesService
        self.cartService = cartService
        self.onFinish = onFinish
    }
    
    func finish() {
        onFinish?()
    }
}
