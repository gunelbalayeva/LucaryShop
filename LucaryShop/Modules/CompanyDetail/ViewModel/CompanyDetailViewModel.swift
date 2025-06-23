//
//  CompanyDetailViewModel.swift
//  LucaryShop
//
//  Created by User on 21.06.25.
//

import Foundation
final class CompanyDetailViewModel {
    private weak var coordinator: CompanyDetailCoordinator?
    private let companyService: CompanyService
    private let productService: ProductService
    private let favoritesService: FavoritesService
    private let cartService: CartService
    private let companyId: Int
    @Published var companyDetail: CompanyDetail?
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    init(coordinator: CompanyDetailCoordinator?,
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

}

