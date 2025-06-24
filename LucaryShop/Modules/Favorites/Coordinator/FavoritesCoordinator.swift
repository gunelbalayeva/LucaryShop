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
    private let cartService: CartService?
    var onFinish: (() -> Void)?
    
    init(parentCoordinator: AppCoordinator? = nil,
         navigationController: UINavigationController,
         profileService: ProfileService,
         favoriteService: FavoritesService,
         productService: ProductService,
         cartService: CartService?) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.profileService = profileService
        self.favoriteService = favoriteService
        self.productService = productService
        self.cartService = cartService
    }
    
    func navigateToProductDetail(with productId: String) {
        let coordinator = ProductDetailCoordinator(
            parentCoordinator: parentCoordinator,
            navigationController: navigationController,
            productService: productService,
            favoritesService: favoriteService,
            cartService: CartService()
        )
        coordinator.start(with: productId)
    }
    
    func start() {
        let viewModel = FavoritesViewModel(favoritesService: favoriteService,
                                           productService: productService,
                                           cartService: cartService)
        let vc = FavoritesViewViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func startAndReturnViewController() -> UIViewController {
        let vc = FavoritesBuilder(favoritesService: favoriteService,
                                 productService: productService,
                                 cartService: cartService,
                                 coordinator: self).build()
        return UINavigationController(rootViewController: vc)
    }
    
    func finish() {
        onFinish?()
    }
}
