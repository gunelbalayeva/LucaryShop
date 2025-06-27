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
    var companyCoordinator: CompanyCoordinator?
    private var orderService:OrderService
    var onFinish: (() -> Void)?
    var productDetailCoordinator: ProductDetailCoordinator?
    
    init(parentCoordinator: AppCoordinator? = nil, navigationController: UINavigationController, productService: ProductService, categoryService: CategoryService, companyService: CompanyService, cartService: CartService, favoritesService: FavoritesService, companyCoordinator: CompanyCoordinator? = nil, orderService: OrderService) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.productService = productService
        self.categoryService = categoryService
        self.companyService = companyService
        self.cartService = cartService
        self.favoritesService = favoritesService
        self.companyCoordinator = companyCoordinator
        self.orderService = orderService
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
    
    
    func navigateToCompany() {
        if let companyVC = navigationController.viewControllers.first(where: { $0 is CompanyViewController }) {
            navigationController.popToViewController(companyVC, animated: true)
            print("Mövcud Company səhifəsinə qayıdıldı")
            return
        }
        let coordinator = CompanyCoordinator(
            parentCoordinator: parentCoordinator,
            navigationController: navigationController,
            companyService: companyService,
            productService: productService,
            favoritesService: favoritesService,
            cartService: cartService, 
            orderService: orderService
        )
        self.companyCoordinator = coordinator
        coordinator.onFinish = { [weak self] in
            self?.companyCoordinator = nil
            print("CompanyCoordinator finish oldu və təmizləndi")
        }
        print("CompanyCoordinator yaradılır və səhifə açılır")
        coordinator.start()
    }



    
    func navigateToCategoriesDetail(categoryId: String) {
        let coordinator = CategoriesDetailCoordinator(
            parentCoordinator: parentCoordinator,
            navigationController: navigationController,
            categoryService: categoryService,
            productService: productService,
            favoritesService: favoritesService,
            cartService: cartService,
            orderService: orderService
        )
        coordinator.onFinish = { [] in
            print("CategoriesDetailCoordinator bitdi")
        }
        coordinator.start(with: categoryId)
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
            cartService: cartService,
            orderService: orderService
        )
        self.productDetailCoordinator = detailCoordinator
        detailCoordinator.onFinish = { [weak self] in
            print("ProductDetailCoordinator bitdi")
            self?.productDetailCoordinator = nil
        }
        detailCoordinator.start(with: productId)
    }

    
    func finish() {
        onFinish?()
    }
}
