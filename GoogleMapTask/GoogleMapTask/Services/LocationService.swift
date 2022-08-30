//
//  LocationManager.swift
//  GoogleMapTask
//
//  Created by Евгений  on 12/08/2022.
//

import Foundation
import CoreLocation
import UIKit

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
    
    //MARK: - Override init method
    override init() {
        super.init()
        manager.delegate = self
    }
    
    //MARK: - Private methods
    private func ckeckAuthorizationStatus(completion: @escaping (Bool?) -> Void) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            let allowed = true
            completion(allowed)
        case .notDetermined:
            let notDetermined: Bool? = nil
            completion(notDetermined)
        default:
            let notAllowed = false
            completion(notAllowed)
        }
    }
    
    private func createGoToSettingAlertAction() {
        let action =  UIAlertAction(title: "Go to Settings",
                                    style: .default) { action  in
            if let url = URL(string:UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }
        UIApplication
            .shared
            .windows
            .first?
            .rootViewController?.showAlert(title: "Error",
                                           message: LocationError.noPermission.description,
                                           actions: [action])
    }
}

//MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.manager.stopUpdatingLocation()
        self.currentLocation = locations.first
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.delegate?.didFailWithError(error: LocationError.noLocation)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        ckeckAuthorizationStatus { status in
            guard let status = status else {
                manager.requestWhenInUseAuthorization()
                return
            }
            status ? manager.startUpdatingLocation() : self.createGoToSettingAlertAction()
        }
    }
}
