//
//  LocationError.swift
//  GoogleMapTask
//
//  Created by Евгений  on 29/08/2022.
//

import Foundation

enum LocationError: String, Error {
    case noLocation = "Location is unavailable"
    case noPermission = "App don't have permission to get location"
}
