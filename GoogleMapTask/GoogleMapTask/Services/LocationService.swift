//
//  LocationManager.swift
//  GoogleMapTask
//
//  Created by Евгений  on 12/08/2022.
//

import Foundation
import CoreLocation

//MARK: - LocationServiceDelegate
protocol LocationServiceDelegate: AnyObject {
    func didUpdateLocation(location: CLLocation)
}

final class LocationService: NSObject {
    
    //MARK: -Properties
    let manager = CLLocationManager()
    weak var delegate: LocationServiceDelegate?
    
    //MARK: - Override init method
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}

//MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.delegate?.didUpdateLocation(location: location)
//        self.manager.stopUpdatingLocation()
    }
}
