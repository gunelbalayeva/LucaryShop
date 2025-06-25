//
//  FavoritesViewModel.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
import Combine

final class FavoritesViewModel {
    private let favoritesService: FavoritesService
    private let productService: ProductService
    private let cartService: CartService?
    private weak var coordinator: FavoritesCoordinator?
    @Published var favorites: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(favoritesService: FavoritesService, productService: ProductService, cartService: CartService?, coordinator: FavoritesCoordinator? = nil) {
        self.favoritesService = favoritesService
        self.productService = productService
        self.cartService = cartService
        self.coordinator = coordinator
    }
    
    func loadFavorites(completion: (() -> Void)? = nil) {
        isLoading = true
        favoritesService.getFavorites { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let products):
                    self?.favorites = products
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
                completion?()
            }
        }
    }

    

    func fetchProductDetailAndNavigate(productId: String) {
        isLoading = true
        productService.fetchProductDetail(id: productId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let product):
                    self?.coordinator?.navigateToProductDetail(with: product.id)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func removeFavorite(productId: String, completion: @escaping () -> Void) {
        isLoading = true
        favoritesService.removeFavorite(productId: productId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    self?.favorites.removeAll { $0.id == productId }
                    completion()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    completion()
                }
            }
        }
    }
    
    
    func goToProductDetail(productId: String) {
        coordinator?.navigateToProductDetail(with: productId)
    }
}
