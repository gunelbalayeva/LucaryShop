//
//  FavoritesBuilder.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
import UIKit

final class FavoritesBuilder{
    private let favoritesService: FavoritesService
    private let productService: ProductService
    private let cartService: CartService?
    private var coordinator: FavoritesCoordinator
    
    init(favoritesService: FavoritesService, productService: ProductService, cartService: CartService?, coordinator: FavoritesCoordinator) {
        self.favoritesService = favoritesService
        self.productService = productService
        self.cartService = cartService
        self.coordinator = coordinator
    }
    
    func build () -> UIViewController {
        let viewmodel = FavoritesViewModel(favoritesService: favoritesService,
                                           productService: productService,
                                           cartService: cartService,
                                           coordinator: coordinator)
        let vc  = FavoritesViewViewController(viewModel: viewmodel)
        return vc
    }
}
