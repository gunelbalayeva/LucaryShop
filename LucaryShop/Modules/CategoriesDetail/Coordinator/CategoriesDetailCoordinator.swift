//
//  CategoriesDetailCoordinator.swift
//  LucaryShop
//
//  Created by User on 26.06.25.
//

import Foundation
import UIKit
final class CategoriesDetailCoordinator:Coordinator{
    func start() {
        
    }
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private let categoryService:CategoryService
    private let productService: ProductService
    private let favoritesService: FavoritesService
    private let cartService: CartService
    private let orderService: OrderService
    var productDetailCoordinator: ProductDetailCoordinator?
    var onFinish: (() -> Void)?
    
    init(parentCoordinator: Coordinator? = nil,
         navigationController: UINavigationController,
         categoryService: CategoryService,
         productService: ProductService,
         favoritesService: FavoritesService,
         cartService: CartService,
         orderService: OrderService) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.categoryService = categoryService
        self.productService = productService
        self.favoritesService = favoritesService
        self.cartService = cartService
        self.orderService = orderService
        print("✅ CategoriesDetail Coordinator YARADILDI")
    }
    
    func start(with categoryId: String) {
        print("🧾 Göndərilən categoryId: \(categoryId)")
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
            cartService: cartService,
            orderService: orderService
        )
        self.productDetailCoordinator = detailCoordinator
        detailCoordinator.start(with: productId)
    }


    
    func finish() {
        onFinish?()
    }
    
    deinit {
        print("❌ CategoriesDetailCoordinator SILINDI")
    }
}
