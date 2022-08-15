//
//  NetworkManager.swift
//  GoogleMapsTask
//
//  Created by Евгений  on 10/08/2022.
//

import Foundation

//MARK: - Protocol
protocol NetworkServiceDelegate: AnyObject {
    func getPlaces(places: [PlacesModel])
    func didFailWithError(error: Error)
}

struct NetworkService {
    //MARK: - Properties
    weak var delegate: NetworkServiceDelegate?
    
    //MARK: - Methods
    func configureURL(lat: Double, lon: Double) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "maps.googleapis.com"
        components.path = "/maps/api/place/nearbysearch/json"
        let location = URLQueryItem(name:"location", value: "\(lat) \(lon)")
        let type = URLQueryItem(name:"type", value: "restaurant")
        let radius = URLQueryItem(name: "radius", value: "5000")
        let key = URLQueryItem(name: "key", value: "\(GoogleMapService.apiKey)")
        components.queryItems = [location, type, radius, key]
        let url = components.url
        return url
    }

    func requestPlaces(url: URL?) {
        guard let url = url else { return }
        let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            if let error = error {
                self.delegate?.didFailWithError(error: error)
                return
            }
            if let safeData = data {
                self.parseData(data: safeData)
            }
        }
        task.resume()
    }
    
    func parseData(data: Data) {
        let decoder = JSONDecoder()
        var requestResults: [PlacesModel] = []
        do {
            let placesData = try decoder.decode(PlacesData?.self, from: data)
            guard let  decodedData = placesData else {return}
            for place in decodedData.results {
                let model = PlacesModel(name: place.name,
                                        longitude: place.geometry.location.longitude,
                                        latitude: place.geometry.location.latitude,
                                        icon: place.icon,
                                        rank: place.rating ?? 0.0)
                requestResults.append(model)
            }
            self.delegate?.getPlaces(places: requestResults)
        } catch {
            self.delegate?.didFailWithError(error: error)
        }
    }
}
