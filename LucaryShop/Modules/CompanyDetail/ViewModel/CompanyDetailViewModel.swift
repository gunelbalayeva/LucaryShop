//
//  CompanyDetailViewModel.swift
//  LucaryShop
//
//  Created by User on 21.06.25.
//

import Foundation
final class CompanyDetailViewModel {
    var coordinator: CompanyDetailCoordinator?
    private let companyService: CompanyService
    private let productService: ProductService
    private let favoritesService: FavoritesService
    private let cartService: CartService
    private let companyId: String
    @Published var companyDetail: CompanyDetails?
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(coordinator: CompanyDetailCoordinator?,
         companyService: CompanyService,
         productService: ProductService,
         favoritesService: FavoritesService,
         cartService: CartService,
         companyId: String) {
        self.coordinator = coordinator
        self.companyService = companyService
        self.productService = productService
        self.favoritesService = favoritesService
        self.cartService = cartService
        self.companyId = companyId
    }
    
    func fetchCompanyDetail() {
        isLoading = true
        productService.fetchProductsByCompany(companyId: companyId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let detail):
                    self?.companyDetail = detail
                    self?.products = detail.products
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Error fetching company detail: \(error)")
                }
            }
        }
    }
    
    func selectProduct(_ product: Product) {
       coordinator?.navigateToProductDetail(productId: product.id)
    }
}

