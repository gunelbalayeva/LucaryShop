//
//  NetworkService.swift
//  LucaryShop
//
//  Created by User on 13.06.25.
//

import Foundation

protocol NetworkService {
    func request<T: Decodable>(_ request: APIRequest, completion: @escaping (Result<T, Error>) -> Void)
}
