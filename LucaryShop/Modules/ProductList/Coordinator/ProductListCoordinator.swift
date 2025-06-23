//
//  ProductListCoordinator.swift
//  LucaryShop
//
//  Created by User on 20.06.25.
//

import Foundation
import UIKit
final class ProductListCoordinator{
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    let productService: ProductService
    let favoritesService: FavoritesService
    let cartService: CartService
    var onFinish: (() -> Void)?
    
    
    init(parentCoordinator: AppCoordinator? = nil, navigationController: UINavigationController, productService: ProductService, favoritesService: FavoritesService, cartService: CartService) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.productService = productService
        self.favoritesService = favoritesService
        self.cartService = cartService
    }
    
    func navigateToProductDetail(productId: Int) {
        let detailCoordinator = ProductDetailCoordinator(
            parentCoordinator: parentCoordinator,
            navigationController: navigationController,
            productService: productService,
            favoritesService: favoritesService,
            cartService: cartService
        )
        detailCoordinator.start(with: productId)
    }

    
    func start(categoryId: Int? = nil) {
        let builder = ProductListBuilder(
            coordinator: self,
            productService: productService,
            favoritesService: favoritesService,
            cartService: cartService
        )
        let vc = builder.build()
        
        if let viewModel = (vc as? ProductListViewController)?.viewModel {
//            viewModel.fetchProducts(categoryId: categoryId)
        }
        
        navigationController.pushViewController(vc, animated: true)
    }

    func finish() {
        onFinish?()
    }
}
