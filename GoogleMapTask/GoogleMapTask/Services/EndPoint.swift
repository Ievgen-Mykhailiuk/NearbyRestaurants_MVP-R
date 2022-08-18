//
//  PlacesAp.swift
//  GoogleMapTask
//
//  Created by Евгений  on 15/08/2022.
//

import Foundation

enum EndPoint {
    case getPlaces(longitude: Double, latitude: Double)
}

extension EndPoint {
    
    var domainComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "maps.googleapis.com"
        components.path = path
        return components
    }
    
    var url: URL? {
        var components = domainComponents
        switch self {
        case .getPlaces( let longitude, let latitude):
            let location = URLQueryItem(name:"location", value: "\(latitude) \(longitude)")
            let type = URLQueryItem(name:"type", value: "restaurant")
            let radius = URLQueryItem(name: "radius", value: "5000")
            let key = URLQueryItem(name: "key", value: "\(Constants.apiKey)")
            components.queryItems = [location, type, radius, key]
        }
        return components.url
    }
    
    var path: String {
        switch self {
        case .getPlaces:
            return "/maps/api/place/nearbysearch/json"
        }
    }
}

