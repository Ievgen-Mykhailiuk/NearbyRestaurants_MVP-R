//
//  NetworkManager.swift
//  GoogleMapsTask
//
//  Created by Евгений  on 10/08/2022.
//

import Foundation

//MARK: - NetworkServiceProtocol
protocol NetworkServiceProtocol {
    func request<T: Codable>(fromURL url: EndPoint,
                             httpMethod: NetworkService.HttpMethod,
                             completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    //MARK: - Network errors
    enum NetworkErrors: String, Error {
        case invalidURL = "invalidURL"
        case invalidResponse = "Invalid response"
        case invalidStatusCode = "Invalid status code"
        case noData = "No data occur"
        case invalidData = "Invalid Data"
    }
    
    //MARK: - Http methods
    enum HttpMethod: String {
        case get
        case post
        var method: String { rawValue.uppercased() }
    }
 
    //MARK: - Network request method
    func request<T: Codable>(fromURL url: EndPoint,
                             httpMethod: HttpMethod = .get,
                             completion: @escaping (Result<T, Error>) -> Void) {
        
        let completionOnMain: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        guard let url = url.endPoint else {
            completionOnMain(.failure(NetworkErrors.invalidURL))
            return }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.method
        
        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completionOnMain(.failure(error))
                return
            }
            
            guard let urlResponse = response as? HTTPURLResponse else {
                completionOnMain(.failure(NetworkErrors.invalidResponse))
                return
            }
            
            if !(200..<300).contains(urlResponse.statusCode) {
                completionOnMain(.failure(NetworkErrors.invalidStatusCode))
                return
            }
            
            guard let data = data else {
                completionOnMain(.failure(NetworkErrors.noData))
                return
            }
            
            do {
                let places = try JSONDecoder().decode(T.self, from: data)
                completionOnMain(.success(places))
            } catch {
                completionOnMain(.failure(NetworkErrors.invalidData))
            }
        }
        urlSession.resume()
    }
}
