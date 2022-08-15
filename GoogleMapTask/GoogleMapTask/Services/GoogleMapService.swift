//
//  GoogleMapService.swift
//  GoogleMapTask
//
//  Created by Евгений  on 12/08/2022.
//

import Foundation
import GoogleMaps

//MARK: - Protocols
protocol GoogleMapServiceProtocol: AnyObject {
    func configure()
    func useApiKey() -> String
}

class GoogleMapService: GoogleMapServiceProtocol {
    
    //MARK: - Properties
    private let apiKey = "AIzaSyBYu4A-M-dIFgIaMcm61RosaP1SB4Ggxww"

    
    //MARK: - Methods
    func configure() {
        GMSServices.provideAPIKey(apiKey)
    }
    
    func useApiKey() -> String {
        return apiKey
    }
}
