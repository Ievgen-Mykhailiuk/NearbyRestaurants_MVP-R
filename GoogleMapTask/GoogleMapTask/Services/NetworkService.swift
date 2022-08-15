//
//  NetworkManager.swift
//  GoogleMapsTask
//
//  Created by Евгений  on 10/08/2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Codable>(fromURL url: PlacesAPI, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    enum Errors: String, Error {
        case invalidURL = "invalidURL"
        case invalidResponse = "Invalid response"
        case invalidStatusCode = "Invalid status code"
        case noData = "No data occur"
        case invalidData = "Invalid Data"
    }
    
    func request<T: Codable>(fromURL url: PlacesAPI, completion: @escaping (Result<T, Error>) -> Void) {
        
        let completionOnMain: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        guard let url = url.url else {
            completionOnMain(.failure(Errors.invalidURL))
            return }
        
        let urlSession = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completionOnMain(.failure(error))
                return
            }
            
            guard let urlResponse = response as? HTTPURLResponse else {
                completionOnMain(.failure(Errors.invalidResponse))
                return
            }
            
            if !(200..<300).contains(urlResponse.statusCode) {
                completionOnMain(.failure(Errors.invalidStatusCode))
                return
            }
            
            guard let data = data else {
                completionOnMain(.failure(Errors.noData))
                return
            }
            
            do {
                let places = try JSONDecoder().decode(T.self, from: data)
                completionOnMain(.success(places))
            } catch {
                completionOnMain(.failure(Errors.invalidData))
            }
        }
        urlSession.resume()
    }
}
