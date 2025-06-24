//
//  CompanyCoordinator.swift
//  LucaryShop
//
//  Created by User on 20.06.25.
//

import Foundation
import UIKit
final class CompanyCoordinator: Coordinator{
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    private let companyService: CompanyService
    private let productService: ProductService
    private let favoritesService: FavoritesService
    private let cartService: CartService
    var onFinish: (() -> Void)?
    
    init(parentCoordinator: AppCoordinator? = nil,
         navigationController: UINavigationController,
         companyService: CompanyService,
         productService: ProductService,
         favoritesService: FavoritesService,
         cartService: CartService) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.companyService = companyService
        self.productService = productService
        self.favoritesService = favoritesService
        self.cartService = cartService
    }
    
    
    func start() {
        let builder = CompanyBuilder(
            coordinator: self,
            companyService: companyService,
            productService: productService,
            favoritesService: favoritesService,
            cartService: cartService
        )
        let vc = builder.build()
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    func navigateToCompanyDetail(companyId: Int) {
        let detailCoordinator = CompanyDetailCoordinator(parentCoordinator: parentCoordinator,
                                                         navigationController: navigationController,
                                                         companyService: companyService,
                                                         productService: productService,
                                                         favoritesService: favoritesService,
                                                         cartService: cartService)
        detailCoordinator.start(with: companyId)
    }
    
    
    func navigateToProductDetail(productId: String) {
        let detailCoordinator = ProductDetailCoordinator(navigationController: navigationController,
                                                         productService: productService,
                                                         favoritesService: favoritesService,
                                                         cartService: cartService)
        detailCoordinator.start(with: productId)
    }
    
    
    func finish() {
        onFinish?()
        parentCoordinator?.childDidFinish(self)
    }
}





