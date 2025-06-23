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

    func fetchCompanyDetail() {
           isLoading = true
           companyService.getCompany(id: companyId) { [weak self] result in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let company):
                       self?.fetchProducts(for: company)
                   case .failure(let error):
                       self?.isLoading = false
                       self?.errorMessage = error.localizedDescription
                   }
               }
           }
       }

       private func fetchProducts(for company: Company) {
           productService.fetchAllProducts(page: 1, size: 20) { [weak self] result in
               DispatchQueue.main.async {
                   self?.isLoading = false
//                   switch result {
//                   case .success(let products):
//                       let companyProducts = products.filter { $0.company?.id == company.id }
//                       self?.companyDetail = CompanyDetail(
//                           id: company.id,
//                           name: company.name,
//                           description: company.description ?? "No description available",
//                           products: companyProducts
//                       )
//                       self?.products = companyProducts
//                   case .failure(let error):
//                       self?.errorMessage = error.localizedDescription
//                   }
               }
           }
       }

       func selectProduct(_ product: Product) {
//           coordinator?.navigateToProductDetail(productId: product.id)
       }
}

