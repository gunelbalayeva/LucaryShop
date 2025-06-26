//
//  CompanyService.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
final class CompanyService {
    private let networkService: NetworkService

    init(networkService: NetworkService = URLSessionNetworkService()) {
        self.networkService = networkService
    }

    func getAllCompanies(completion: @escaping (Result<[Company], Error>) -> Void) {
        networkService.request(CompanyEndpoint.getAll.request, completion: completion)
    }

    func getCompany(id: String, completion: @escaping (Result<Company, Error>) -> Void) {
        networkService.request(CompanyEndpoint.getById(id).request, completion: completion)
    }

}
