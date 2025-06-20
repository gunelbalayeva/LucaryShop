//
//  ProductListBuilder.swift
//  LucaryShop
//
//  Created by User on 20.06.25.
//

import Foundation
import UIKit
final class ProductListBuilder{
    private var coordinator: ProductListCoordinator
    let productService: ProductService
    let favoritesService: FavoritesService
    let cartService: CartService
    
    init(coordinator: ProductListCoordinator, productService: ProductService, favoritesService: FavoritesService, cartService: CartService) {
        self.coordinator = coordinator
        self.productService = productService
        self.favoritesService = favoritesService
        self.cartService = cartService
    }
    
    func build () -> UIViewController {
        let viewModel = ProductListViewModel(coordinator: coordinator,
                                             productService: productService,
                                             favoritesService: favoritesService,
                                             cartService: cartService)
        let vc  = ProductListViewController(viewModel: viewModel)
        return vc
    }
}
