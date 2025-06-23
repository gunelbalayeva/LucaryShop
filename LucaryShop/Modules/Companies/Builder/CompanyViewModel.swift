//
//  CompanyViewModel.swift
//  LucaryShop
//
//  Created by User on 20.06.25.
//

import Foundation
import Combine

final class CompanyViewModel {
    private weak var coordinator: CompanyCoordinator?
    private let companyService: CompanyService
    private let productService: ProductService
    private let favoritesService: FavoritesService
    private let cartService: CartService

    @Published private(set) var companies: [Company] = []
    @Published private(set) var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    init(coordinator: CompanyCoordinator? = nil, companyService: CompanyService, productService: ProductService, favoritesService: FavoritesService, cartService: CartService) {
        self.coordinator = coordinator
        self.companyService = companyService
        self.productService = productService
        self.favoritesService = favoritesService
        self.cartService = cartService
    }



    func selectCompany(_ company: Company) {
        coordinator?.navigateToCompanyDetail(companyId: company.id)
    }

    func selectProduct(_ product: Product) {
//        coordinator?.navigateToProductDetail(productId: product.id)
    }
}
