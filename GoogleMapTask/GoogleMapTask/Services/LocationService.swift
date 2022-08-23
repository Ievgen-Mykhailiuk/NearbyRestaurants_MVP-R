//
//  LocationManager.swift
//  GoogleMapTask
//
//  Created by Евгений  on 12/08/2022.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func didUpdateLocation(location: CLLocation)
}

final class LocationService: NSObject {
    
    //MARK: - Properties
    private let manager = CLLocationManager()
    private var currentLocation: CLLocation? {
        didSet {
            guard let location = self.currentLocation else { return }
            self.delegate?.didUpdateLocation(location: location)
        }
    }
    weak var delegate: LocationServiceDelegate?
    
    //MARK: - Errors
    enum LocationError: String, Error {
        case noLocation = "Current location unavailable"
    }
    
    //MARK: - Override init method
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }
        
    //MARK: - Provide location method
    func startUpdateLocation() {
        manager.startUpdatingLocation()
    }
}

//MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.manager.stopUpdatingLocation()
        guard let location = locations.first else { return }
        self.currentLocation = location
    }
}
