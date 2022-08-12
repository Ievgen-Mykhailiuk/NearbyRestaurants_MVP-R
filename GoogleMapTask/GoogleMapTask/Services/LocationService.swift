//
//  LocationManager.swift
//  GoogleMapTask
//
//  Created by Евгений  on 12/08/2022.
//

import Foundation
import CoreLocation

//MARK: - Protocols
protocol LocationServiceProtocol: AnyObject {
    func getCurrentLocation(location: CLLocation)
}

class LocationService: NSObject {

    //MARK: -Properties
    private var manager = CLLocationManager()
    weak var delegate: LocationServiceProtocol?
    
    //MARK: - Override methods
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}

//MARK: - Extensions
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.delegate?.getCurrentLocation(location: location)
    }
}
