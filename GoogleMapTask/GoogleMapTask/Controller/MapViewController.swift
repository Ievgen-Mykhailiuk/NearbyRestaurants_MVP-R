//
//  ViewController.swift
//  GoogleMapsTask
//
//  Created by Евгений  on 09/08/2022.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController  {
    
    var networkManager = NetworkManager()
    let locationManager = CLLocationManager()
    var places: [PlacesModel] = []
    var mapView = GMSMapView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func addMarkers() {
        DispatchQueue.main.async {
            let geocoder = GMSGeocoder()
            for place in self.places {
                geocoder.reverseGeocodeCoordinate(CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)) { response , error in
                 
                    if let location = response?.firstResult() {
                        let marker = GMSMarker()
                        let lines = location.lines! as [String]
                        marker.position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                        marker.title = place.name
                        marker.snippet = lines.joined(separator: "\n")
                        marker.map = self.mapView
                    }
                }
            }
        }
    }
    
    func setUpMap(coordinates: CLLocationCoordinate2D)  {
        let camera = GMSCameraPosition.camera(withLatitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 14)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.zoomGestures = true
        self.view.addSubview(mapView)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let coordinates = location.coordinate
        setUpMap(coordinates: coordinates)
        networkManager.requestPlaces(lat: coordinates.latitude, lon: coordinates.longitude)
        locationManager.stopUpdatingLocation()
    }
}

extension MapViewController: NetworkManagerDelegate {
    func getPlaces(places: [PlacesModel]) {
        DispatchQueue.main.async {
            self.places = places
            self.addMarkers()
        }
    }
    
    func didFailwithError(error: Error) {
        print(error.localizedDescription)
    }
}
