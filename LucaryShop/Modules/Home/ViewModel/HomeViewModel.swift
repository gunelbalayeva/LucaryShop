//
//  HomeViewModel.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
final class HomeViewModel {
     weak var coordinator: HomeCoordinator?
    private let productService: ProductService
    private let categoryService: CategoryService
    private let companyService :CompanyService
    
    @Published var newArrivals: [Product] = []
    @Published var categories: [Category] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var companies: [Company] = []

    init(coordinator: HomeCoordinator? = nil,
         productService: ProductService,
         categoryService: CategoryService,
         companyService: CompanyService) {
        self.coordinator = coordinator
        self.productService = productService
        self.categoryService = categoryService
        self.companyService = companyService
    }
    
    

    func navigateToCompanies() {
        coordinator?.navigateToCategory()
    }
}
