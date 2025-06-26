//
//  CategoriesDetailBuilder.swift
//  LucaryShop
//
//  Created by User on 26.06.25.
//

import Foundation
import UIKit
final class CategoriesDetailBuilder{
    
    private let categoryId: Int
    private let categoryService: CategoryService
    private let productService: ProductService
    weak var coordinator: CategoriesDetailCoordinator?
    
    init(categoryId: Int,
         categoryService: CategoryService,
         productService: ProductService,
         coordinator: CategoriesDetailCoordinator? = nil) {
        self.categoryId = categoryId
        self.categoryService = categoryService
        self.productService = productService
        self.coordinator = coordinator
    }
    
    func build () -> UIViewController {
        let viewModel = CategoriesDetailViewModel(categoryId: categoryId,
                                                  categoryService: categoryService,
                                                  productService: productService,
                                                  coordinator: coordinator)
        let vc  =  CategoriesDetailViewController(viewModel: viewModel)
        return vc
    }
    
}
