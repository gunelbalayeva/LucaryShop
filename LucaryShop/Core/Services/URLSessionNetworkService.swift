//
//  URLSessionNetworkService.swift
//  LucaryShop
//
//  Created by User on 13.06.25.
//

import Foundation

final class URLSessionNetworkService: NetworkService {
    func request<T: Decodable>(_ request: APIRequest, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.perform(request, completion: completion)
    }
}
