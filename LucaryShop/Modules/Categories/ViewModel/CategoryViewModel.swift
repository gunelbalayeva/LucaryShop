//
//  CategoryViewModel.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
import UIKit
import Combine
final class CategoryViewModel {
     weak var coordinator: CategoryCoordinator?
    private let categoryService: CategoryService
    private let productService: ProductService?
    @Published var categories: [Category] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(coordinator: CategoryCoordinator? = nil, categoryService: CategoryService,
         productService: ProductService?) {
        self.coordinator = coordinator
        self.categoryService = categoryService
        self.productService = productService
        self.categories = categories
        self.isLoading = isLoading
        self.errorMessage = errorMessage
    }
    
    
    
    func selectCategory(_ category: Category) {
        coordinator?.navigateToProductList(for: category.id)
    }
}
