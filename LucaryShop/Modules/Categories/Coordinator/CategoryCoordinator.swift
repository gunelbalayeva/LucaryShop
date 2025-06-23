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
    weak var homeCoordinator: HomeCoordinator?
    let categoryService: CategoryService
    let productService: ProductService
    let favoritesService: FavoritesService
    let cartService: CartService
    let companyService: CompanyService

    var onFinish: (() -> Void)?
    
    init(parentCoordinator: AppCoordinator? = nil, navigationController: UINavigationController, homeCoordinator: HomeCoordinator? = nil, categoryService: CategoryService, productService: ProductService, favoritesService: FavoritesService, cartService: CartService, companyService: CompanyService) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.homeCoordinator = homeCoordinator
        self.categoryService = categoryService
        self.productService = productService
        self.favoritesService = favoritesService
        self.cartService = cartService
        self.companyService = companyService
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
    
    func start() {
           let viewModel = CategoryViewModel(coordinator: self,
                                             categoryService: categoryService,
                                             productService: productService)
           let vc = CategoryViewController(viewModel: viewModel)
           navigationController.pushViewController(vc, animated: true)
       }
       
      
    func navigateToHome() {
            navigationController.popViewController(animated: true)
            homeCoordinator?.updateHomeSelectedIndex(0)
            onFinish?()
        }
       
       func finish() {
           onFinish?()
       }
}
