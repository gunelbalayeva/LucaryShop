//
//  ProductListViewModel.swift
//  LucaryShop
//
//  Created by User on 20.06.25.
//

import Foundation
import Combine

final class ProductListViewModel {
    
    private weak var coordinator: ProductListCoordinator?
    let productService: ProductService
    let favoritesService: FavoritesService
    let cartService: CartService
    
    @Published private(set) var allProducts: [Product] = []
    @Published var filteredProducts: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var currentCategoryId: Int?
    private var currentSearchText: String = ""
    
    init(coordinator: ProductListCoordinator? = nil, productService: ProductService, favoritesService: FavoritesService, cartService: CartService) {
        self.coordinator = coordinator
        self.productService = productService
        self.favoritesService = favoritesService
        self.cartService = cartService
    }
    
    func fetchProducts(categoryId: Int?) {
        isLoading = true
        errorMessage = nil
        currentCategoryId = categoryId
        
        if let categoryId = categoryId {
            productService.fetchProducts(by: categoryId) { [weak self] result in
                self?.handleFetchResult(result)
            }
        } else {
            productService.fetchAllProducts(page: 1, size: 20) { [weak self] result in
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
//                self.applyFilters()
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func updateSearchText(_ text: String) {
        currentSearchText = text
//        applyFilters()
    }
    
//    private func applyFilters() {
//        if let intId = String(product.id) {
//            coordinator?.navigateToProductDetail(productId: intId)
//        } else {
//            errorMessage = "Product ID is invalid"
//        }
//
//    }
    
//    func selectProduct(_ product: Product) {
//        coordinator?.navigateToProductDetail(productId: product.id)
//    }
}
