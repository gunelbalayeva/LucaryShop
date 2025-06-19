//
//  FavoritesCoordinator.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
import UIKit
final class FavoritesCoordinator{
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    private let profileService: ProfileService
    private let favoriteService: FavoritesService
    private let productService: ProductService
    var onFinish: (() -> Void)?
    
    init(parentCoordinator: AppCoordinator? = nil, navigationController: UINavigationController, profileService: ProfileService, favoriteService: FavoritesService, productService: ProductService) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.profileService = profileService
        self.favoriteService = favoriteService
        self.productService = productService
    }
    
    
    
    func navigateToProductDetail(with productId: Int) {
        let coordinator = ProductDetailCoordinator(
            parentCoordinator: parentCoordinator,
            navigationController: navigationController,
            productService: productService,
            favoritesService: favoriteService,
            cartService: CartService()
        )
        coordinator.start(with: productId)
    }

}
