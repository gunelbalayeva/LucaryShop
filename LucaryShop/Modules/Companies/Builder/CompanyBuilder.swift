//
//  CpmpanyBuilder.swift
//  LucaryShop
//
//  Created by User on 20.06.25.
//

import Foundation
import UIKit
final class CompanyBuilder{
    private var coordinator: CompanyCoordinator
    private let companyService: CompanyService
    private let productService: ProductService
    private let favoritesService: FavoritesService
    private let cartService: CartService
    
    init(coordinator: CompanyCoordinator,
         companyService: CompanyService,
         productService: ProductService,
         favoritesService: FavoritesService,
         cartService: CartService) {
        self.coordinator = coordinator
        self.companyService = companyService
        self.productService = productService
        self.favoritesService = favoritesService
        self.cartService = cartService
    }
    
    func build () -> UIViewController {
        let viewModel = CompanyViewModel(coordinator: coordinator,
                                         companyService: companyService,
                                         productService: productService,
                                         favoritesService: favoritesService,
                                         cartService: cartService)
        let vc  = CompanyViewController(viewModel: viewModel)
        return vc
    }    
}
