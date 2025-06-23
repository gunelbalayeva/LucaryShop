//
//  ProductDetailViewModel.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
import Combine
final class ProductDetailViewModel {
    private let productId: Int
    private let productService: ProductService
    private let favoritesService: FavoritesService
    private let cartService: CartService
    private weak var coordinator: ProductDetailCoordinator?
    
    @Published var product: Product?
    @Published var isFavorite: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(productId: Int,
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
    
    
    func toggleFavorite() {
        guard let product = product else { return }
        isFavorite.toggle()
        if isFavorite {
            favoritesService.addFavorite(productId: productId) { [weak self] result in
                if case .failure(let error) = result {
                    self?.errorMessage = error.localizedDescription
                }
            }
        } else {
            favoritesService.removeFavorite(productId: productId) { [weak self] result in
                if case .failure(let error) = result {
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    
    
//    func addToCart() {
//        guard let productDetail = product else { return }
//        let product = Product(id: productDetail.id,
//                              name: productDetail.name,
//                              description: productDetail.description,
//                              price: productDetail.price,
//                              imgUrls: [productDetail.description?],
//                              favorite: productDetail.favorite)
//        
//        cartService.addToCart(product: product) { [weak self] result in
//            if case .failure(let error) = result {
//                self?.errorMessage = error.localizedDescription
//            }
//        }
//    }
    
}
