//
//  CompanyCoordinator.swift
//  LucaryShop
//
//  Created by User on 20.06.25.
//

import Foundation
import UIKit
final class CompanyCoordinator{
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    private let companyService: CompanyService
    private let productService: ProductService
    private let favoritesService: FavoritesService
    private let cartService: CartService
    var onFinish: (() -> Void)?
    var productDetailCoordinator: ProductDetailCoordinator?
    var companyDetailCoordinator:CompanyDetailCoordinator?
    
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
    
    
    func navigateToProductDetail(productId: String) {
        let detailCoordinator = ProductDetailCoordinator(
            parentCoordinator: parentCoordinator,
            navigationController: navigationController,
            productService: productService,
            favoritesService: favoritesService,
            cartService: cartService
        )
        self.productDetailCoordinator = detailCoordinator
        detailCoordinator.start(with: productId)
    }
    
    
    func navigateToCompaniesDetail(companyId: String){
        let companiesCoordinator = CompanyDetailCoordinator(navigationController: navigationController,
                                                            companyService: companyService,
                                                            productService: productService,
                                                            favoritesService: favoritesService,
                                                            cartService: cartService
        )
        self.companyDetailCoordinator = companiesCoordinator
        companiesCoordinator.start(with: companyId)
    }
    
    
    func finish() {
        onFinish?()
    }
}
