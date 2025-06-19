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
    private weak var coordinator: CategoryCoordinator?
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
    
    func fetchCategories() {
        isLoading = true
        categoryService.fetchCategories { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let categories):
                    self.categories = categories
                    self.errorMessage = nil
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.categories = []
                }
            }
        }
    }
    
    
    func selectCategory(_ category: Category) {
        coordinator?.navigateToProductList(for: category.id)
    }
}
