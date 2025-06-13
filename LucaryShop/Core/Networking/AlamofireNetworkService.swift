//
//  AlamofireManager.swift
//  LucaryShop
//
//  Created by User on 07.06.25.

import Foundation
import Alamofire
final class AlamofireNetworkService: NetworkService {
    func request<T: Decodable>(_ request: APIRequest, completion: @escaping (Result<T, Error>) -> Void) {
        let url = request.url
        let headers = HTTPHeaders(request.headers.map { HTTPHeader(name: $0.key, value: $0.value) })
        var parameters: [String: Any]?
        if let body = request.body {
            do {
                parameters = try JSONSerialization.jsonObject(with: body) as? [String: Any]
            } catch {
                completion(.failure(NetworkError.decodingError(error)))
                return
            }
        }
        AF.request(
            url,
            method: HTTPMethod(rawValue: request.method),
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let afError):
                if let statusCode = response.response?.statusCode {
                    completion(.failure(NetworkError.invalidResponse(statusCode: statusCode)))
                } else if response.data?.isEmpty == true {
                    completion(.failure(NetworkError.emptyData))
                } else {
                    completion(.failure(NetworkError.decodingError(afError)))
                }
            }
        }
    }
}
