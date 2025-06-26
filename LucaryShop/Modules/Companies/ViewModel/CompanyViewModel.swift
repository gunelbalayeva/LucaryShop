//
//  CompanyViewModel.swift
//  LucaryShop
//
//  Created by User on 20.06.25.
//

import Foundation
import Combine

final class CompanyViewModel {
    var coordinator: CompanyCoordinator?
    private let companyService: CompanyService
    private let productService: ProductService
    private let favoritesService: FavoritesService
    private let cartService: CartService
    @Published private(set) var companies: [Company] = []
    @Published private(set) var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    init(coordinator: CompanyCoordinator? = nil,
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


    func fetchCompanies() {
        isLoading = true
        companyService.getAllCompanies { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let companies):
                    self?.companies = companies
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Error fetching companies: \(error)")
                }
            }
        }
    }
}
