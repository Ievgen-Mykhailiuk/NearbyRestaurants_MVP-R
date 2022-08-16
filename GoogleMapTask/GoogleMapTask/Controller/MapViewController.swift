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
    private var mapView: GMSMapView!
    private var currentLocation: CLLocation? {
        didSet {
            if let location = currentLocation {
                requestPlaces(location: location)
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
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 14.0)
        mapView.animate(to: camera)
    }
    
    private func addMarker(place: PlacesModel) {
        let marker = GMSMarker()
        let location = CLLocation(latitude: place.latitude, longitude: place.longitude)
        marker.position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        marker.title = place.name
        locationManager.getAddress(location: location) { (result: Result<String, Error>) in
            switch result {
            case .success(let address):
                marker.snippet = address
            case .failure(let error):
                self.showAlert(title: "Error", buttonTitle: "OK", error: error)
            }
        }
        marker.map = self.mapView
    }
    
    private func requestPlaces(location: CLLocation) {
        networkManager.request(fromURL: .getPlaces(longitude: location.coordinate.longitude, latitude: location.coordinate.latitude)) { (result: Result<PlacesData, Error>) in
            switch result {
            case .success(let places):
                places.results.forEach { place in
                    let placeModel = PlacesModel(name: place.name,
                                                 longitude: place.geometry.location.longitude,
                                                 latitude: place.geometry.location.latitude,
                                                 icon: place.icon,
                                                 rank: place.rating ?? 0.0)
                    DispatchQueue.main.async {
                        self.addMarker(place: placeModel)
                    }
                }
            case .failure(let error):
                self.showAlert(title: "Error", buttonTitle: "OK", error: error)
            }
        }
    }
}

//MARK: - Extensions
extension MapViewController: LocationServiceProtocol {
    func getCurrentLocation(location: CLLocation) {
        DispatchQueue.main.async {
            self.currentLocation = location
            self.setMapCamera(location: location)
        }
    }
}
