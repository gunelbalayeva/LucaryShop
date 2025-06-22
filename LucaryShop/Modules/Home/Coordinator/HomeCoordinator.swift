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
    
    
    init(parentCoordinator: AppCoordinator? = nil, navigationController: UINavigationController, productService: ProductService, categoryService: CategoryService, companyService: CompanyService, cartService: CartService, favoritesService: FavoritesService) {
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
                                      companyService: companyService)
        let vc = HomeViewController(homeViewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }

    func navigateToCategory() {
        print("navigateToCategory çağırıldı")
        DispatchQueue.main.async {
            let coordinator = CategoryCoordinator(navigationController: self.navigationController,
                                                  categoryService: self.categoryService,
                                                  productService: self.productService,
                                                  favoritesService: self.favoritesService,
                                                  cartService: self.cartService)
            self.categoryCoordinator = coordinator
            coordinator.start()
            print("Coordinator start çağırıldı")
        }
    }


    func startAndReturnViewController() -> UIViewController {
        let viewModel = HomeViewModel(coordinator: self,
                                      productService: productService,
                                      categoryService: categoryService,
                                      companyService: companyService)
        let vc = HomeViewController(homeViewModel: viewModel)
        return vc
    }

    func finish(){
        onFinish?()
    }
}
