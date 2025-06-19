//
//  ProductService.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class ProductService {
    private let networkService: NetworkService

    init(networkService: NetworkService = URLSessionNetworkService()) {
        self.networkService = networkService
    }
    
    func fetchAllProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        networkService.request(ProductEndpoint.getAll.request, completion: completion)
    }

    func fetchProductDetail(id: Int, completion: @escaping (Result<ProductDetail, Error>) -> Void) {
        networkService.request(ProductEndpoint.getById(id).request, completion: completion)
    }
    
    func fetchProducts(by categoryId: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
        networkService.request(ProductEndpoint.getByCategory(categoryId).request, completion: completion)
    }

}
