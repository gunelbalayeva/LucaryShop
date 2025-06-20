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

    func fetchCompanies() {
        isLoading = true
        errorMessage = nil
        companyService.getAllCompanies { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let companies):
                    self?.companies = companies
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func fetchProducts(for companyId: Int) {
        isLoading = true
        errorMessage = nil
        productService.fetchAllProducts { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let allProducts):
                    self?.products = allProducts.filter { $0.company?.id == companyId }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func addFavorite(productId: Int) {
        favoritesService.addFavorite(productId: productId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("Added to favorites")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func addToCart(product: Product) {
        cartService.addToCart(product: product) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("Added to cart")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }


    func selectCompany(_ company: Company) {
        coordinator?.navigateToCompanyDetail(companyId: company.id)
    }

    func selectProduct(_ product: Product) {
//        coordinator?.navigateToProductDetail(productId: product.id)
    }
}
