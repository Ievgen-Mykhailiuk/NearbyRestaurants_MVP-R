//
//  PlacesData.swift
//  GoogleMapTask
//
//  Created by Евгений  on 12/08/2022.
//

import Foundation

struct PlacesData: Codable {
    let results: [Result]
}

struct Result: Codable {
    let geometry: Geometry
    let icon: String
    let name: String
    let rating: Double?
}

struct Geometry: Codable {
    let location: Location
}

struct Location: Codable {
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}
