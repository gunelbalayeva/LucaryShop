//
//  CompanyDetailBuilder.swift
//  LucaryShop
//
//  Created by User on 21.06.25.
//

import Foundation
import UIKit
final class CompanyDetailBuilder{
    private var coordinator: CompanyDetailCoordinator
    private let companyService: CompanyService
    private let productService: ProductService
    private let favoritesService: FavoritesService
    private let cartService: CartService
    private let companyId: Int
    
    init(coordinator: CompanyDetailCoordinator,
         companyService: CompanyService,
         productService: ProductService,
         favoritesService: FavoritesService,
         cartService: CartService,
         companyId: Int) {
        self.coordinator = coordinator
        self.companyService = companyService
        self.productService = productService
        self.favoritesService = favoritesService
        self.cartService = cartService
        self.companyId = companyId
    }
    
    func build () -> UIViewController {
        let viewModel = CompanyDetailViewModel(coordinator: coordinator,
                                               companyService: companyService,
                                               productService: productService,
                                               favoritesService: favoritesService,
                                               cartService: cartService, companyId: companyId)
        let vc  = CompanyDetailViewController(viewModel: viewModel)
        return vc
    }
}
