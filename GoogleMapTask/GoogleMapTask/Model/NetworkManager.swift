//
//  NetworkManager.swift
//  GoogleMapsTask
//
//  Created by Евгений  on 10/08/2022.
//

import Foundation

//MARK: - Protocol
protocol NetworkManagerDelegate: AnyObject {
    func getPlaces(places: [PlacesModel])
    func didFailwithError(error: Error)
}

struct NetworkManager {
    //MARK: - Properties
    weak var delegate: NetworkManagerDelegate?
    
    //MARK: - Methods
    func requestPlaces(lat: Double, lon: Double) {
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lat)%2C\(lon)&radius=5000&type=restaurant&key=AIzaSyBYu4A-M-dIFgIaMcm61RosaP1SB4Ggxww"
        if let url = URL(string: urlString) {
            let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    self.delegate?.didFailwithError(error: error)
                    return
                }
                if let safeData = data {
                    self.parseData(data: safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseData(data: Data) {
        DispatchQueue.main.async {
            var searchResults: [PlacesModel] = []
            guard let data = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                print("Fail to parse data");
                return
            }
            if let results = data["results"] as? [Any] {
                results.forEach { resultDict in
                    if let result = resultDict as? [String : Any] {
                        if let name = result["name"] as? String,
                           let geometryDict = result["geometry"] as? [String : Any] {
                            if let locationDict = geometryDict["location"] as? [String : Any] {
                                if let lat = locationDict["lat"] as? Double, let lng = locationDict["lng"] as? Double {
                                    let place = PlacesModel(name: name, longitude: lng, latitude: lat)
                                    searchResults.append(place)
                                }
                            }
                        }
                    }
                }
                self.delegate?.getPlaces(places: searchResults)
            }
        }
    }
}
