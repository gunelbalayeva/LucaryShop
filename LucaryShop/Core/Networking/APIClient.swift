//
//  APIClient.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation

protocol APIClientProtocol {
    func send<T: Decodable>(
        request: APIRequest,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

final class APIClient: APIClientProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func send<T: Decodable>(
        request: APIRequest,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        session.perform(request, completion: completion)
    }
}
