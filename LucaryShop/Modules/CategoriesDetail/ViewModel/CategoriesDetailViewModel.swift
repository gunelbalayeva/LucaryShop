//
//  CategoriesDetailViewModel.swift
//  LucaryShop
//
//  Created by User on 26.06.25.
//

import Foundation
final class CategoriesDetailViewModel{
    private let categoryId: String
    private let categoryService: CategoryService
    private let productService: ProductService
    var coordinator: CategoriesDetailCoordinator?
    @Published private(set) var products: [Product] = []
    @Published private(set) var categoryInfo: Category?
    @Published var categoryName: String?

    init(categoryId: String,
         categoryService: CategoryService,
         productService: ProductService,
         coordinator: CategoriesDetailCoordinator?) {
        self.categoryId = categoryId
        self.categoryService = categoryService
        self.productService = productService
        self.coordinator = coordinator
    }
    

    func fetchProducts() {
        productService.fetchProducts(by: categoryId, pageNumber: 0, pageSize: 20) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.products = response.products
                    self?.categoryName = response.name
                }
            case .failure(let error):
                print("Error fetching products: \(error)")
            }
        }
    }

}
