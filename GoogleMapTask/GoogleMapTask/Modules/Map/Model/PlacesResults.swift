//
//  PlacesResults.swift
//  GoogleMapTask
//
//  Created by Евгений  on 12/08/2022.
//

import Foundation

struct PlacesResults: Codable {
    let results: [PlacesModel]
}

struct PlacesModel: Codable {
    let location: Location
    let iconUrl: String
    let name: String
    let rating: Double?
    let address: String
    
    enum CodingKeys: String, CodingKey{
        case location = "geometry"
        case iconUrl = "icon"
        case address = "vicinity"
        case name, rating
    }
}

struct Location: Codable {
    let coordinates: Coordinates
    
    enum CodingKeys: String, CodingKey {
        case coordinates = "location"
    }
}

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}
