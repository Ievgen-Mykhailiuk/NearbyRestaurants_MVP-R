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
    private let locationManager = LocationService()
    private let networkManager = NetworkService()
    private var mapView: GMSMapView!
    private var placesArray = [PlacesModel]()
    private var currentLocation: CLLocation? {
        didSet {
            fetchPlaces(location: currentLocation)
        }
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    //MARK: - Private Methods
    private func initialSetup() {
        setupMap()
        locationManager.delegate = self
    }
    
    private func setupMap() {
        mapView = GMSMapView.map(withFrame: view.frame, camera: GMSCameraPosition())
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        view.addSubview(mapView)
    }
    
    private func setMapCamera(location: CLLocation) {
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: 14.0)
        mapView.animate(to: camera)
    }

    private func fetchPlaces(location: CLLocation?) {
        guard let location = location else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        // make network request for places
        networkManager.request(fromURL: .getPlaces(longitude: longitude, latitude: latitude),
                               httpMethod: .get) {
            [weak self] (result: Result<PlacesResults, Error>) in
            switch result {
            case .success(let places):
                DispatchQueue.main.async {
                    
                    // save results to property
                    self?.placesArray = places.results
                  
                    // add markers to map
                    self?.placesArray.forEach { place in
                        self?.addMarker(name: place.name,
                                        address: place.address,
                                        longitude: place.location.coordinates.longitude,
                                        latitude: place.location.coordinates.latitude)
                    }
                }
            case .failure(let error):
                self?.showAlert(title: "OK", message: error.localizedDescription)
            }
        }
    }
    
    private func addMarker(name: String,
                           address: String,
                           longitude: Double,
                           latitude: Double) {
        
        // setup marker
        let marker = GMSMarker()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        marker.position = location.coordinate
        marker.title = name
        marker.snippet = address
        marker.map = self.mapView
    }
}

//MARK: - LocationServiceDelegate
extension MapViewController: LocationServiceDelegate {
    func didUpdateLocation(location: CLLocation) {
        self.currentLocation = location
        self.setMapCamera(location: location)
    }
}
