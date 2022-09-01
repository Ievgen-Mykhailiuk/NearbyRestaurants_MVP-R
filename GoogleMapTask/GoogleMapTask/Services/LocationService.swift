//
//  LocationService.swift
//  GoogleMapTask
//
//  Created by Евгений  on 12/08/2022.
//

import CoreLocation
import UIKit

protocol LocationServiceDelegate: AnyObject {
    func didUpdateLocation(location: CLLocation?)
    func didFailWithError(error: String)
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
    
    //MARK: - Override init method
    override init() {
        super.init()
        manager.delegate = self
    }
    
    //MARK: - Private methods
    private func ckeckAuthorizationStatus(completion: @escaping (Bool) -> Void) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            completion(true)
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
             completion(false)
        }
    }
    
    private func showDeniedStatusAlert() {
        let notNowAction = UIAlertAction(title: "Not now",
                                         style: .default)
        let goToSettingsAction =  UIAlertAction(title: "Go to Settings",
                                                style: .default) { action  in
            UIApplication.openSettings()
        }
        UIApplication.keyWindowViewController?.showAlert(title: "Error",
                                                         message: LocationError.noPermission.rawValue,
                                                         actions: [notNowAction, goToSettingsAction])
    }
}

//MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.manager.stopUpdatingLocation()
        self.currentLocation = locations.first
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.delegate?.didFailWithError(error: error.localizedDescription)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        ckeckAuthorizationStatus { status in
            status ? manager.startUpdatingLocation() : self.showDeniedStatusAlert()
        }
    }
}
