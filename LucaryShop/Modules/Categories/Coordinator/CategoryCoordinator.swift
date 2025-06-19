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

    init(
        parentCoordinator: AppCoordinator? = nil,
        navigationController: UINavigationController,
        categoryService: CategoryService,
        productService: ProductService
    ) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.categoryService = categoryService
        self.productService = productService
    }

    func navigateToProductList(for categoryId: Int) {
//        let coordinator = ProductListCoordinator(
//            parentCoordinator: parentCoordinator,
//            navigationController: navigationController,
//            productService: productService,
//            categoryId: categoryId
//        )
//        coordinator.start()
    }
}
