//
//  HomeCoordinator.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class HomeCoordinator {
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    let productService: ProductService
    let categoryService: CategoryService
    let companyService: CompanyService
    let cartService: CartService
    let favoritesService: FavoritesService
    var categoryCoordinator: CategoryCoordinator?
    var onFinish: (() -> Void)?
    var productDetailCoordinator: ProductDetailCoordinator?    
    init(parentCoordinator: AppCoordinator? = nil,
         navigationController: UINavigationController,
         productService: ProductService,
         categoryService: CategoryService,
         companyService: CompanyService,
         cartService: CartService,
         favoritesService: FavoritesService) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.productService = productService
        self.categoryService = categoryService
        self.companyService = companyService
        self.cartService = cartService
        self.favoritesService = favoritesService
        
    }
    
    
    func start() {
        let viewModel = HomeViewModel(coordinator: self,
                                      productService: productService,
                                      categoryService: categoryService,
                                      companyService: companyService,
                                      favoritesService: favoritesService)
        let vc = HomeViewController(homeViewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    func navigateToCategory() {
        if categoryCoordinator == nil {
            let coordinator = CategoryCoordinator(
                parentCoordinator: self.parentCoordinator,
                navigationController: navigationController,
                categoryService: categoryService,
                productService: productService,
                favoritesService: favoritesService,
                cartService: cartService,
                companyService: companyService
            )
            self.categoryCoordinator = coordinator
            coordinator.onFinish = { [weak self] in
                self?.categoryCoordinator = nil
            }
            coordinator.start()
        }
    }
    
    
    func startAndReturnViewController() -> UIViewController {
        let viewModel = HomeViewModel(coordinator: self,
                                      productService: productService,
                                      categoryService: categoryService,
                                      companyService: companyService,
                                      favoritesService: favoritesService)
        let vc = HomeViewController(homeViewModel: viewModel)
        return vc
    }
    
    
    func updateHomeSelectedIndex(_ index: Int) {
        if let vc = navigationController.viewControllers.last as? HomeViewController {
            vc.updateSelectedIndex(index)
        }
    }
    
    
    func navigateToProductDetail(productId: String) {
        let detailCoordinator = ProductDetailCoordinator(
            parentCoordinator: self.parentCoordinator,
            navigationController: navigationController,
            productService: productService,
            favoritesService: favoritesService,
            cartService: cartService
        )
        detailCoordinator.onFinish = { [weak self] in
            print("ProductDetailCoordinator bitdi")
        }
        detailCoordinator.start(with: productId)
    }
    
    func finish() {
        onFinish?()
    }
}
