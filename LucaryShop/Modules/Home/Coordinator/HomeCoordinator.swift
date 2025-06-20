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
    var onFinish: (() -> Void)?
    
    init(parentCoordinator: AppCoordinator? = nil, navigationController: UINavigationController, productService: ProductService, categoryService: CategoryService, companyService: CompanyService) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.productService = productService
        self.categoryService = categoryService
        self.companyService = companyService
    }
    
    func start() {
            let viewModel = HomeViewModel(
                coordinator: self,
                productService: productService,
                categoryService: categoryService,
                companyService: companyService
            )
            let vc = HomeViewController(homeViewModel: viewModel)
            navigationController.setViewControllers([vc], animated: true)
        }
    
    func finish(){
        onFinish?()
    }
}
