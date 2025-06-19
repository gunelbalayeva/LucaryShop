//
//  HomeViewModel.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
final class HomeViewModel {
    private let productService: ProductService
    private let categoryService: CategoryService
    private weak var coordinator: HomeCoordinator?

    @Published var newArrivals: [Product] = []
    @Published var categories: [Category] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    init(productService: ProductService,
         categoryService: CategoryService,
         coordinator: HomeCoordinator?) {
        self.productService = productService
        self.categoryService = categoryService
        self.coordinator = coordinator
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
    }
}
