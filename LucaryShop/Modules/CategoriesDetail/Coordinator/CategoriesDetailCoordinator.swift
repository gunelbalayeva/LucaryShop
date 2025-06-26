//
//  CategoriesDetailCoordinator.swift
//  LucaryShop
//
//  Created by User on 26.06.25.
//

import Foundation
import UIKit
final class CategoriesDetailCoordinator{
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    private let categoryService:CategoryService
    private let productService: ProductService
    private let favoritesService: FavoritesService
    private let cartService: CartService
    var productDetailCoordinator: ProductDetailCoordinator?
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
    
    
    func start(with categoryId: String) {
        let viewModel = CategoriesDetailViewModel(categoryId:categoryId ,
                                                  categoryService: categoryService,
                                                  productService: productService,
                                                  coordinator: self
        )
        let vc = CategoriesDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    func navigateToProductDetail(productId: String) {
        let detailCoordinator = ProductDetailCoordinator(
            parentCoordinator: parentCoordinator,
            navigationController: navigationController,
            productService: productService,
            favoritesService: favoritesService,
            cartService: cartService
        )
        self.productDetailCoordinator = detailCoordinator
        detailCoordinator.start(with: productId)
    }


    
    func finish() {
        onFinish?()
    }
}
