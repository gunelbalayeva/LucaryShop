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
    var onFinish: (() -> Void)?
    
    init(parentCoordinator: AppCoordinator? = nil, navigationController: UINavigationController, productService: ProductService, categoryService: CategoryService, onFinish: ( () -> Void)? = nil) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.productService = productService
        self.categoryService = categoryService
        self.onFinish = onFinish
    }
    
}
