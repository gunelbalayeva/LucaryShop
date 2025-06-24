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
    private let companyService: CompanyService
    
    @Published var newArrivals: [Product] = []
    @Published var companies: [Company] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var currentPage = 1
    private let pageSize = 20
    private var isLoadingMore = false
    
    init(coordinator: HomeCoordinator? = nil,
         productService: ProductService,
         categoryService: CategoryService,
         companyService: CompanyService) {
        self.coordinator = coordinator
        self.productService = productService
        self.categoryService = categoryService
        self.companyService = companyService
    }
    
    private var hasLoadedHomeData = false

    func fetchHomeData() {
        guard !hasLoadedHomeData else {
            print("Artıq yüklənib, təkrar request atılmır.")
            return
        }

        hasLoadedHomeData = true
        isLoading = true
        currentPage = 1
        newArrivals.removeAll()

        productService.fetchAllProducts(page: currentPage, size: pageSize) { [weak self] result in
            DispatchQueue.main.async {
                print("Yeni sorgu atıldı: \(self!.currentPage)")
                switch result {
                case .success(let products):
                    print("Gələn məhsullar: \(products.count)")
                    self?.newArrivals = products
                case .failure(let error):
                    print(" API xətası: \(error)")
                    self?.errorMessage = error.localizedDescription
                    self?.hasLoadedHomeData = false
                }
            }
        }
        companyService.getAllCompanies { _ in }
        categoryService.fetchCategories { _ in }
    }

    func loadNextPageIfNeeded(currentIndex: Int) {
        guard !isLoadingMore, currentIndex >= newArrivals.count - 4 else { return }
        
        isLoadingMore = true
        productService.fetchAllProducts(page: currentPage + 1, size: pageSize) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoadingMore = false
                switch result {
                case .success(let products):
                    if !products.isEmpty {
                        self?.currentPage += 1
                        self?.newArrivals.append(contentsOf: products)
                    }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func navigateToCompanies() {
        coordinator?.navigateToCategory()
    }
}
