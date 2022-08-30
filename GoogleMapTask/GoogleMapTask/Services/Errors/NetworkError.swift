//
//  NetworkError.swift
//  GoogleMapTask
//
//  Created by Евгений  on 29/08/2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidStatusCode
    case noData
    case invalidData
}

extension NetworkError {
    var description: String {
        switch self {
        case .invalidURL:
            return "invalid URL"
        case .invalidResponse:
            return "Invalid response"
        case .invalidStatusCode:
            return "Invalid status code"
        case .noData:
            return "No data occure"
        case .invalidData:
            return "Invalid Data"
        }
    }
}
