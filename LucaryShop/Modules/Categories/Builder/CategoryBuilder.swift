//
//  CategoryBuilder.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
import UIKit
final class CategoryBuilder{
    private var coordinator: CategoryCoordinator
    private let categoryService: CategoryService
    private let productService: ProductService?
    
    init(coordinator: CategoryCoordinator, categoryService: CategoryService, productService: ProductService?) {
        self.coordinator = coordinator
        self.categoryService = categoryService
        self.productService = productService
    }
    
    
    func build () -> UIViewController {
        let viewModel = CategoryViewModel(coordinator: coordinator,
                                          categoryService: categoryService,
                                          productService: productService)
        let vc  = CategoryViewController(ViewModel: viewModel)
        return vc
    }
}
