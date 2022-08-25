//
//  LocationManager.swift
//  GoogleMapTask
//
//  Created by Евгений  on 12/08/2022.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func didUpdateLocation(location: CLLocation?)
    func didFailWithError(error: Error)
}

final class LocationService: NSObject {
    
    //MARK: - Properties
    private let manager = CLLocationManager()
    private var hasPermission = true
    private var currentLocation: CLLocation? {
        didSet {
            self.delegate?.didUpdateLocation(location: currentLocation)
        }
    }
    weak var delegate: LocationServiceDelegate?
    
    //MARK: - Errors
    enum LocationError: String, Error {
        case noLocation = "Location is unavailable"
        case noPermission = "Don't have permission to get location"
    }
    
    //MARK: - Override init method
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }
    
    //MARK: - Provide location method
    func startUpdatingLocation() {
        hasPermission ? manager.startUpdatingLocation() :
                        self.delegate?.didFailWithError(error: LocationError.noPermission)
    }
}

//MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.manager.stopUpdatingLocation()
        self.currentLocation = locations.first
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.delegate?.didFailWithError(error: error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .restricted, .denied:
            hasPermission = false
        default:
            hasPermission = true
        }
    }
}
