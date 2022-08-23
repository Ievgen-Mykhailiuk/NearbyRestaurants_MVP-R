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
}

final class LocationService: NSObject {
    
    //MARK: - Properties
    private let manager = CLLocationManager()
    private var currentLocation: CLLocation? {
        didSet {
            self.delegate?.didUpdateLocation(location: currentLocation)
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
    func startUpdatingLocation() {
        manager.startUpdatingLocation()
    }
}

//MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.manager.stopUpdatingLocation()
        let location = locations.first 
        self.currentLocation = location
    }
}
