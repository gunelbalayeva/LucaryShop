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

    func getCompany(id: Int, completion: @escaping (Result<Company, Error>) -> Void) {
        networkService.request(CompanyEndpoint.getById(id).request, completion: completion)
    }

    func createCompany(request: CompanyRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        networkService.request(CompanyEndpoint.create(request).request) { (result: Result<EmptyResponse, Error>) in
            completion(result.map { _ in () })
        }
    }

    func updateCompany(id: Int, request: CompanyRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        networkService.request(CompanyEndpoint.update(id: id, request).request) { (result: Result<EmptyResponse, Error>) in
            completion(result.map { _ in () })
        }
    }

    func deleteCompany(id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        networkService.request(CompanyEndpoint.delete(id: id).request) { (result: Result<EmptyResponse, Error>) in
            completion(result.map { _ in () })
        }
    }
}
