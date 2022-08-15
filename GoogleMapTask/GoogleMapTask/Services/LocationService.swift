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
    
    //MARK: - Methods
    func getAddress(location: CLLocation, completion: @escaping (String) -> Void) {
        let geocoder = CLGeocoder()
        var address = [String]()
        geocoder.reverseGeocodeLocation(location) { response , error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let obj = response?.first {
                if let building = obj.subThoroughfare {
                    address.append(building)
                }
                if let street = obj.thoroughfare {
                    address.append(street)
                }
                if let city = obj.locality {
                    address.append(city)
                }
                if let country = obj.country {
                    address.append(country)
                }
                completion(address.joined(separator: ", "))
            }
        }
    }
}

//MARK: - Extensions
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.delegate?.getCurrentLocation(location: location)
    }
}
