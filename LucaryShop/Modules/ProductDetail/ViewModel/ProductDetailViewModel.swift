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
    private weak var coordinator: ProductDetailCoordinator?
    
    @Published var product: Product?
    @Published var isFavorite: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(productId: String,
         productService: ProductService,
         favoritesService: FavoritesService,
         cartService: CartService,
         coordinator: ProductDetailCoordinator?) {
        self.productId = productId
        self.productService = productService
        self.favoritesService = favoritesService
        self.cartService = cartService
        self.coordinator = coordinator
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
