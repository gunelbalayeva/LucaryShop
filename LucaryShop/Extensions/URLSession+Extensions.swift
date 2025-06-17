//
//  URLSession+Extensions.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
extension URLSession {
    func perform<T: Decodable>(_ request: APIRequest,decoder: JSONDecoder = JSONDecoder(),
                               completion: @escaping (Result<T, Error>) -> Void) {
        let urlRequest = RequestBuilder.build(request)
        let task = self.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse(statusCode: -1)))
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse(statusCode: httpResponse.statusCode)))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.emptyData))
                return
            }
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NetworkError.decodingError(error)))
            }
        }
        task.resume()
    }
}
