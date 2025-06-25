//
//  ProductDetailViewModel.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
import Combine
final class ProductDetailViewModel {
    private let productId: String
    private let productService: ProductService
    private let favoritesService: FavoritesService
    private let cartService: CartService
    weak var coordinator: ProductDetailCoordinator?
    private weak var homeViewModel: HomeViewModel?

    
    @Published var product: Product?
    @Published var isFavorite: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(productId: String, productService: ProductService, favoritesService: FavoritesService, cartService: CartService, coordinator: ProductDetailCoordinator? = nil, homeViewModel: HomeViewModel? = nil) {
        self.productId = productId
        self.productService = productService
        self.favoritesService = favoritesService
        self.cartService = cartService
        self.coordinator = coordinator
        self.homeViewModel = homeViewModel
    }
    
    func fetchProductDetail() {
        isLoading = true
        productService.fetchProductDetail(id: productId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let product):
                    self?.product = product
                    self?.isFavorite = product.favorite
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func toggleFavorite() {
        guard let product = product else { return }
        let wasFavorite = product.favorite
        let newFavorite = !wasFavorite

        self.product?.favorite = newFavorite
        self.isFavorite = newFavorite

        let request = newFavorite
            ? favoritesService.addFavorite
            : favoritesService.removeFavorite

        request(productId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("Favori status serverdə yeniləndi")
                    self?.homeViewModel?.updateFavoriteStatus(for: product.id, isFavorite: newFavorite)
                case .failure:
                    print("Server favori statusunu dəyişə bilmədi")
                    self?.product?.favorite = wasFavorite
                    self?.isFavorite = wasFavorite
                    self?.errorMessage = "Server favori statusunu dəyişə bilmədi"
                }
            }
        }
    }



    
    private func revertFavoriteState(wasFavorite: Bool) {
        product?.favorite = wasFavorite
        isFavorite = wasFavorite
        errorMessage = "Server xətası: Favori status dəyişmədi"
    }
    
    func addToCart() {
        guard let product = product else { return }
        cartService.addToCart(product: product) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("Məhsul səbətə əlavə edildi")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
