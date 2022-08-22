//
//  LocationManager.swift
//  GoogleMapTask
//
//  Created by Евгений  on 12/08/2022.
//

import Foundation
import CoreLocation

final class LocationService: NSObject {
    
    //MARK: - Properties
    private let manager = CLLocationManager()
    private var currentLocation: CLLocation?
    
    //MARK: - Errors
    enum LocationError: String, Error {
        case noLocation = "Current location unavailable"
    }
    
    //MARK: - Override init method
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    //MARK: - Provide location method
    func provideCurrentLocation(completion: (Result<CLLocation, Error>) -> Void) {
        guard let location = self.currentLocation else {
            completion(.failure(LocationError.noLocation))
            return
        }
        completion(.success(location))
    }
}

//MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.manager.stopUpdatingLocation()
        self.currentLocation = location
    }
}
