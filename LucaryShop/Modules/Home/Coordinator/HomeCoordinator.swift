//
//  HomeCoordinator.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class HomeCoordinator: Coordinator {
    func start(with categoryId: String) {
        
    }
     var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    // Servislər
    let productService: ProductService
    let categoryService: CategoryService
    let companyService: CompanyService
    let cartService: CartService
    let favoritesService: FavoritesService
    private let orderService: OrderService
    
    // Child coordinatorlar
     var companyCoordinator: CompanyCoordinator?
     var productDetailCoordinator: ProductDetailCoordinator?
     var categoriesDetailCoordinator: CategoriesDetailCoordinator?
    
    var onFinish: (() -> Void)?
    
    init(parentCoordinator: Coordinator? = nil,
         navigationController: UINavigationController,
         productService: ProductService,
         categoryService: CategoryService,
         companyService: CompanyService,
         cartService: CartService,
         favoritesService: FavoritesService,
         orderService: OrderService) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.productService = productService
        self.categoryService = categoryService
        self.companyService = companyService
        self.cartService = cartService
        self.favoritesService = favoritesService
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
    
    func childDidFinish(_ child: Coordinator) {
        childCoordinators.removeAll { $0 === child }

        if child is CategoriesDetailCoordinator {
            categoriesDetailCoordinator = nil
        } else if child is CompanyCoordinator {
            companyCoordinator = nil
        } else if child is ProductDetailCoordinator {
            productDetailCoordinator = nil
        }
    }

    
    // MARK: - Navigation Methods
    
    func navigateToCompany() {
        if let companyVC = navigationController.viewControllers.first(where: { $0 is CompanyViewController }) {
            navigationController.popToViewController(companyVC, animated: true)
            return
        }
        
        let coordinator = CompanyCoordinator(
            parentCoordinator: self,
            navigationController: navigationController,
            companyService: companyService,
            productService: productService,
            favoritesService: favoritesService,
            cartService: cartService,
            orderService: orderService
        )
        
        self.companyCoordinator = coordinator
        childCoordinators.append(coordinator)
        
        coordinator.onFinish = { [weak self] in
            self?.childDidFinish(coordinator)
            print("CompanyCoordinator finish oldu və təmizləndi")
        }
        
        print("CompanyCoordinator yaradılır və səhifə açılır")
        coordinator.start()
    }
    
    func navigateToCategoriesDetail(categoryId: String) {
        print("➡️ navigateToCategoriesDetail çağırıldı")
        let coordinator = CategoriesDetailCoordinator(
            parentCoordinator: self,
            navigationController: navigationController,
            categoryService: categoryService,
            productService: productService,
            favoritesService: favoritesService,
            cartService: cartService,
            orderService: orderService
        )
        
        self.categoriesDetailCoordinator = coordinator
        self.childCoordinators.append(coordinator)

        coordinator.onFinish = { [weak self, weak coordinator] in
            guard let self, let coordinator else { return }
            self.childDidFinish(coordinator)
            print("CategoriesDetailCoordinator finish oldu")
        }
        coordinator.start(with: categoryId)
    }

    func navigateToProductDetail(productId: String) {
        let detailCoordinator = ProductDetailCoordinator(
            parentCoordinator: self,
            navigationController: navigationController,
            productService: productService,
            favoritesService: favoritesService,
            cartService: cartService,
            orderService: orderService
        )
        
        self.productDetailCoordinator = detailCoordinator
        childCoordinators.append(detailCoordinator)
        
        detailCoordinator.onFinish = { [weak self] in
            self?.childDidFinish(detailCoordinator)
            print("ProductDetailCoordinator bitdi")
        }
        
        detailCoordinator.start(with: productId)
    }
    
    // MARK: - Helper Methods
    func updateHomeSelectedIndex(_ index: Int) {
        if let vc = navigationController.viewControllers.last as? HomeViewController {
            vc.updateSelectedIndex(index)
        }
    }
    
    func finish() {
        onFinish?()
    }
    
}
