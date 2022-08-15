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
    
    func getAdress(location: CLLocation, completion: @escaping (String) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { response , error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let position = response?.first {
                if let country = position.country,
                   let town = position.locality,
                   let street = position.thoroughfare {
                    let adress = country + town + street
                    completion(adress)
                }
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



//func getAddress(latitude: Double, longitude: Double, completion: @escaping (String) -> Void) {
//        var address = [String]()
//        let geoCoder = CLGeocoder()
//        let location = CLLocation(latitude: latitude, longitude: longitude)
//        
//        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
//            guard error == nil else {
//                completion("")
//                return
//            }
//            
//            let placeMark = placemarks?[0]
//            
//            if let street = placeMark?.thoroughfare {
//                address.append(street)
//            }
//            
//            if let city = placeMark?.locality {
//                address.append(city)
//            }
//            
//            if let country = placeMark?.country {
//                address.append(country)
//            }
//            
//            completion(address.joined(separator: ", "))
//        })
//    }
