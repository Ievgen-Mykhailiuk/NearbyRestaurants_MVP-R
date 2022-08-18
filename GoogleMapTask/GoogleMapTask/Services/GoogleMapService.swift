//
//  GoogleMapService.swift
//  GoogleMapTask
//
//  Created by Евгений  on 12/08/2022.
//

import Foundation
import GoogleMaps

protocol GoogleMapServiceProtocol: AnyObject {
    func configure()
}

class GoogleMapService: GoogleMapServiceProtocol {
    
    func configure() {
        GMSServices.provideAPIKey(Constants.apiKey)
    }
}
