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
     let favoritesService: FavoritesService
    @Published var newArrivals: [Product] = []
    @Published var companies: [Company] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var updatedFavoriteProductIds: Set<String> = []

    private var currentPage = 1
    private let pageSize = 20
    private var isLoadingMore = false
    init(coordinator: HomeCoordinator? = nil,
         productService: ProductService,
         categoryService: CategoryService,
         companyService: CompanyService,
         favoritesService: FavoritesService) {
        self.coordinator = coordinator
        self.productService = productService
        self.categoryService = categoryService
        self.companyService = companyService
        self.favoritesService = favoritesService
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
    
    
    func toggleFavorite(for productId: String, completion: @escaping (Bool) -> Void) {
        guard let index = newArrivals.firstIndex(where: { $0.id == productId }) else {
            completion(false)
            return
        }

        let isCurrentlyFav = newArrivals[index].favorite
        newArrivals[index].favorite.toggle()
        let newIsFav = newArrivals[index].favorite

        if newIsFav {
            favoritesService.addFavorite(productId: productId) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self.updatedFavoriteProductIds.insert(productId)
                        completion(true)
                    case .failure:
                        self.newArrivals[index].favorite = isCurrentlyFav
                        completion(false)
                    }
                }
            }
        } else {
            favoritesService.removeFavorite(productId: productId) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self.updatedFavoriteProductIds.remove(productId)
                        completion(true)
                    case .failure:
                        self.newArrivals[index].favorite = isCurrentlyFav
                        completion(false)
                    }
                }
            }
        }
    }

    private var favoriteProductIds: Set<String> = []

    func fetchFavorites() {
        favoritesService.getFavorites { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self?.favoriteProductIds = Set(products.map { $0.id })
                    self?.updateFavoritesInNewArrivals()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func removeFavorite(productId: String, completion: @escaping () -> Void) {
            favoritesService.removeFavorite(productId: productId) { [weak self] result in
                DispatchQueue.main.async {
                    if case .success = result {
                        self?.updateFavoriteStatus(for: productId, isFavorite: false)
                    }
                    completion()
                }
            }
        }

    private func updateFavoritesInNewArrivals() {
        for i in 0..<newArrivals.count {
            newArrivals[i].favorite = favoriteProductIds.contains(newArrivals[i].id)
        }
    }
    
    func updateFavoriteStatus(for productId: String, isFavorite: Bool) {
        if let index = newArrivals.firstIndex(where: { $0.id == productId }) {
            newArrivals[index].favorite = isFavorite
        }
    }


    func navigateToCompanies() {
        coordinator?.navigateToCategory()
    }
}
