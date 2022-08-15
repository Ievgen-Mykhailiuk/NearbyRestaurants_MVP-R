//
//  PlacesModel.swift
//  GoogleMapsTask
//
//  Created by Евгений  on 09/08/2022.
//

import Foundation

struct PlacesModel: Codable {
    let name: String
    let longitude: Double
    let latitude: Double
    let icon: String
    let rank: Double
}
