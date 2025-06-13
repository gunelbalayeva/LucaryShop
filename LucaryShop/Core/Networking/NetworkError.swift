//
//  NetworkError.swift
//  LucaryShop
//
//  Created by User on 13.06.25.
//

import Foundation
enum NetworkError: Error {
    case invalidResponse(statusCode: Int)
    case emptyData
    case decodingError(Error)
}
