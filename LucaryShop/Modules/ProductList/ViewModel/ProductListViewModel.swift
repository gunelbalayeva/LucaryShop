//
//  ProductListViewModel.swift
//  LucaryShop
//
//  Created by User on 20.06.25.
//

import Foundation
import Combine

final class ProductListViewModel {
    private let productService: ProductService
    private weak var coordinator: ProductListCoordinator?
    
    @Published private(set) var allProducts: [Product] = []
    @Published var filteredProducts: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var currentCategoryId: Int?
    private var currentSearchText: String = ""
    
    init(productService: ProductService, coordinator: ProductListCoordinator?) {
        self.productService = productService
        self.coordinator = coordinator
    }
    
    func fetchProducts(categoryId: Int?) {
        isLoading = true
        errorMessage = nil
        currentCategoryId = categoryId
        
        if let categoryId = categoryId {
            // Əgər server query dəstəkləyirsə:
            productService.fetchProducts(by: categoryId) { [weak self] result in
                self?.handleFetchResult(result)
            }
        } else {
            // Bütün məhsulları çək (home və ya search üçün)
            productService.fetchAllProducts { [weak self] result in
                self?.handleFetchResult(result)
            }
        }
    }
    
    private func handleFetchResult(_ result: Result<[Product], Error>) {
        DispatchQueue.main.async {
            self.isLoading = false
            switch result {
            case .success(let products):
                self.allProducts = products
                self.applyFilters()
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func updateSearchText(_ text: String) {
        currentSearchText = text
        applyFilters()
    }
    
    private func applyFilters() {
        var products = allProducts
        
        // Client-side category filter əgər server query yoxdursa
        if let categoryId = currentCategoryId {
            products = products.filter { $0.categoryId == categoryId }
        }
        
        // Search bar filter
        if !currentSearchText.isEmpty {
            products = products.filter {
                $0.name.lowercased().contains(currentSearchText.lowercased())
            }
        }
        
        filteredProducts = products
    }
    
    func selectProduct(_ product: Product) {
//        coordinator?.navigateToProductDetail(productId: product.id)
    }
}
