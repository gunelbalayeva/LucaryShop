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
    
    func fetchHomeData() {
        isLoading = true
        let group = DispatchGroup()
        
        group.enter()
        productService.fetchAllProducts { [weak self] result in
            defer { group.leave() }
            switch result {
            case .success(let products):
                self?.newArrivals = products
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
        
        group.enter()
        categoryService.fetchCategories { [weak self] result in
            defer { group.leave() }
            switch result {
            case .success(let categories):
                self?.categories = categories
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
        group.notify(queue: .main) {
            self.isLoading = false
        }
        
        group.enter()
        companyService.getAllCompanies { [weak self] result in
            defer { group.leave() }
            switch result {
            case .success(let companies):
                self?.companies = companies
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    func navigateToCompanies() {
        coordinator?.navigateToCategory()
    }
}
