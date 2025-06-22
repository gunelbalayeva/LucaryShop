//
//  CategoryCoordinator.swift
//  LucaryShop
//
//  Created by User on 20.06.25.
//

import Foundation
import UIKit

final class CategoryCoordinator {
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    let categoryService: CategoryService
    let productService: ProductService
    let favoritesService: FavoritesService
    let cartService: CartService
    var onFinish: (() -> Void)?
    
    init(parentCoordinator: AppCoordinator? = nil,
         navigationController: UINavigationController,
         categoryService: CategoryService,
         productService: ProductService,
         favoritesService: FavoritesService,
         cartService: CartService) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.categoryService = categoryService
        self.productService = productService
        self.favoritesService = favoritesService
        self.cartService = cartService
    }
    
    func start() {
            let viewModel = CategoryViewModel(categoryService: categoryService,
                                              productService: productService)
            let vc = CategoryViewController(ViewModel: viewModel)
            navigationController.pushViewController(vc, animated: true)
        }
    
    func navigateToProductList(for categoryId: Int) {
        let coordinator = ProductListCoordinator(
            parentCoordinator: parentCoordinator,
            navigationController: navigationController,
            productService: productService,
            favoritesService: favoritesService,
            cartService: cartService
        )
        coordinator.start(categoryId: categoryId)
    }
    
    func finish() {
        onFinish?()
    }
}
