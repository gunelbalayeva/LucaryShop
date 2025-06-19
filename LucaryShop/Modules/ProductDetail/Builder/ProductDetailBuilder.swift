//
//  ProductDetailBuilder.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class ProductDetailBuilder {
    private let productId: Int
    private let productService: ProductService
    private let favoritesService: FavoritesService
    private let cartService: CartService
    private var coordinator: ProductDetailCoordinator
   
    init(productId: Int, productService: ProductService,
         favoritesService: FavoritesService, cartService: CartService,
         coordinator: ProductDetailCoordinator) {
        self.productId = productId
        self.productService = productService
        self.favoritesService = favoritesService
        self.cartService = cartService
        self.coordinator = coordinator
    }
    
    func build () -> UIViewController {
        let viewmodel = ProductDetailViewModel(productId: productId,
                                               productService: productService,
                                               favoritesService: favoritesService,
                                               cartService: cartService,
                                               coordinator: coordinator)
        let vc  = ProductDetailViewController(viewModel: viewmodel)
        return vc
    }
}
