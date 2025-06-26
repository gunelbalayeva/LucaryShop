//
//  CategoriesDetailViewModel.swift
//  LucaryShop
//
//  Created by User on 26.06.25.
//

import Foundation
final class CategoriesDetailViewModel{
    private let categoryId: Int
    private let categoryService: CategoryService
    private let productService: ProductService
    weak var coordinator: CategoriesDetailCoordinator?
    
    @Published private(set) var products: [Product] = []
    @Published private(set) var categoryInfo: Category?
    
    init(categoryId: Int,
         categoryService: CategoryService,
         productService: ProductService,
         coordinator: CategoriesDetailCoordinator?) {
        self.categoryId = categoryId
        self.categoryService = categoryService
        self.productService = productService
        self.coordinator = coordinator
    }
    
    func fetchProducts() {
        productService.fetchProducts(by: String(categoryId), pageNumber: 0, pageSize: 20) { [weak self] result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self?.products = products
                }
            case .failure(let error):
                print("Error fetching products: \(error)")
            }
        }
    }

    
}
