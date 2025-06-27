//
//  CompanyDetailCoordinator.swift
//  LucaryShop
//
//  Created by User on 21.06.25.
//

import Foundation
import UIKit
final class CompanyDetailCoordinator {
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    private let companyService: CompanyService
    private let productService: ProductService
    private let favoritesService: FavoritesService
    private let cartService: CartService
    private var orderService:OrderService
    var onFinish: (() -> Void)?

    init(parentCoordinator: AppCoordinator? = nil, navigationController: UINavigationController, companyService: CompanyService, productService: ProductService, favoritesService: FavoritesService, cartService: CartService, orderService: OrderService) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.companyService = companyService
        self.productService = productService
        self.favoritesService = favoritesService
        self.cartService = cartService
        self.orderService = orderService
    }

    func start(with companyId: String) {
        let viewModel = CompanyDetailViewModel(
            coordinator: self,
            companyService: companyService,
            productService: productService,
            favoritesService: favoritesService,
            cartService: cartService,
            companyId: companyId
        )
        let vc = CompanyDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }

    func navigateToProductDetail(productId: String) {
        let detailCoordinator = ProductDetailCoordinator(
            parentCoordinator: parentCoordinator,
            navigationController: navigationController,
            productService: productService,
            favoritesService: favoritesService,
            cartService: cartService, 
            orderService: orderService
        )
        detailCoordinator.start(with: productId)
    }

    func finish() {
        onFinish?()
    }
}
