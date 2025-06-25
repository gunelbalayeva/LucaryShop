//
//  CategoryService.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
final class CategoryService {
    private let networkService: NetworkService

    init(networkService: NetworkService = URLSessionNetworkService()) {
        self.networkService = networkService
    }

    func fetchCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        networkService.request(CategoryEndpoint.getAll.request, completion: completion)
    }
}
