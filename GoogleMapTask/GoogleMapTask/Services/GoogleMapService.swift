//
//  GoogleMapService.swift
//  GoogleMapTask
//
//  Created by Евгений  on 12/08/2022.
//

import Foundation
import GoogleMaps

//MARK: - Protocols
protocol GoogleMapServiceProtocol: AnyObject {
    func createMap(on view: UIView)
    func updateMapCamera(location: CLLocation)
    func addMarkers(places: [PlacesModel])
}

class GoogleMapService: GoogleMapServiceProtocol {
    
    //MARK: - Properties
    static let apiKey = "AIzaSyBYu4A-M-dIFgIaMcm61RosaP1SB4Ggxww"
    var mapView = GMSMapView()
    
    //MARK: - Methods
    func createMap(on view: UIView) {
        mapView.frame = view.bounds
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        view.addSubview(mapView)
    }
    
    func updateMapCamera(location: CLLocation) {
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 14.0)
        mapView.animate(to: camera)
    }
    
    func addMarkers(places: [PlacesModel]) {
        let geocoder = GMSGeocoder()
        places.forEach { place in
            geocoder.reverseGeocodeCoordinate(CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)) { response , error in
                if let error = error {
                    print(error.localizedDescription)
                }
                if let location = response?.firstResult() {
                    let marker = GMSMarker()
                    if let lines = location.lines {
                        marker.position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                        marker.title = place.name
                        marker.snippet = lines.joined(separator: "\n")
                        marker.map = self.mapView
                    }
                }
            }
        }
    }
}
