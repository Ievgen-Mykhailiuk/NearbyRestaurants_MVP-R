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
    private var mapView = GMSMapView()
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
        setupMap()
        networkManager.delegate = self
        locationManager.delegate = self
    }
    
    func setupMap() {
        mapView.frame = view.bounds
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        view.addSubview(mapView)
    }
    
    func updateMapCamera(location: CLLocation) {
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 14.0)
        mapView.animate(to: camera)
    }
    
    func addMarker(place: PlacesModel) {
        let marker = GMSMarker()
        let location = CLLocation(latitude: place.latitude, longitude: place.longitude)
        marker.position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        marker.title = place.name
        locationManager.getAdress(location: location) { address in
            marker.snippet = address
        }
        marker.map = self.mapView
    }
}

//MARK: - Extensions
extension MapViewController: NetworkServiceDelegate {
    func getPlaces(places: [PlacesModel]) {
        DispatchQueue.main.async {
            places.forEach  { place in
                self.addMarker(place: place)
            }
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
            self.updateMapCamera(location: location)
        }
    }
}
