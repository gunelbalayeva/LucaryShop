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
    

    func goToProductDetail(productId: String) {
        coordinator?.navigateToProductDetail(with: productId)
    }
}
