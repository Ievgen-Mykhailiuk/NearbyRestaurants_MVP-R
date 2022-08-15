//
//  ViewController.swift
//  GoogleMapsTask
//
//  Created by Евгений  on 09/08/2022.
//

import UIKit
import GoogleMaps
import CoreLocation

final class MapViewController: UIViewController {
    
    //MARK: - Properties
    private var locationManager = LocationService()
    private var networkManager = NetworkService()
    private let mapManager = GoogleMapService()
    private var currentLocation: CLLocation? {
        didSet {
            if let location = currentLocation {
            self.networkManager.requestPlaces(url: self.networkManager.configureURL(lat: location.coordinate.latitude, lon: location.coordinate.longitude))
            }
        }
    }

    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
  //MARK: - Methods
    private func initialSetup() {
        mapManager.createMap(on: self.view)
        networkManager.delegate = self
        locationManager.delegate = self
        
    }
}

//MARK: - Extensions
extension MapViewController: NetworkServiceDelegate {
    func getPlaces(places: [PlacesModel]) {
        DispatchQueue.main.async {
            self.mapManager.addMarkers(places: places)
        }
    }
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}

extension MapViewController: LocationServiceProtocol {
    func getCurrentLocation(location: CLLocation) {
        DispatchQueue.main.async {
            self.currentLocation = location
            self.mapManager.updateMapCamera(location: location)
        }
    }
}
