//
//  LocationError.swift
//  GoogleMapTask
//
//  Created by Евгений  on 29/08/2022.
//

import Foundation

enum LocationError: Error {
    case noLocation
    case noPermission
}

extension LocationError {
    var description: String {
        switch self {
        case .noLocation:
            return "Location is unavailable"
        case .noPermission:
            return "App don't have permission to get location"
        }
    }
}
