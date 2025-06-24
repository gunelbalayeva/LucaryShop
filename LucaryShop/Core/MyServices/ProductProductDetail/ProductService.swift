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

    func fetchAllProducts(page: Int, size: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
        let endpoint = ProductEndpoint.getAll(page: page, size: size)
        request(with: endpoint, completion: completion)
    }
    

    func fetchProductDetail(id: String, completion: @escaping (Result<Product, Error>) -> Void) {
        let endpoint = ProductEndpoint.getById(id)
        request(with: endpoint, completion: completion)
    }

    func fetchProducts(by categoryId: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
        let endpoint = ProductEndpoint.getByCategory(categoryId)
        request(with: endpoint, completion: completion)
    }

    
    private func request<T: Decodable>(with endpoint: ProductEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
        var headers = endpoint.headers
        if let token = KeychainManager.shared.getToken() {
            headers["Authorization"] = "Bearer \(token)"
        }

        let apiRequest = APIRequest(
            url: endpoint.url,
            method: endpoint.method,
            headers: headers,
            body: nil
        )
        networkService.request(apiRequest, completion: completion)
    }
}

