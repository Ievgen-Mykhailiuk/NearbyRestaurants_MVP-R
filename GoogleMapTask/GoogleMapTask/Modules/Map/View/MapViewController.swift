//
//  ViewController.swift
//  GoogleMapsTask
//
//  Created by Евгений  on 09/08/2022.
//

import UIKit
import GoogleMaps
import CoreLocation

protocol MapViewProtocol: AnyObject {
    func showPlaces(places: [PlacesModel])
    func didFailWithError(error: Error)
    func didUpdateLocation(location: CLLocation?)
}

final class MapViewController: UIViewController {
    
    //MARK: - Properties
    private var mapView: GMSMapView!
    var presenter: MapViewPresenterProtocol!
    lazy private var listButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 20, y: 80 , width: 100, height: 30)
        button.backgroundColor = .blue
        button.alpha = 0.6
        button.setTitle("Show list", for: .normal)
        button.makeRounded()
        button.addTarget(self,
                         action: #selector(showListButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        presenter.viewDidLoad()
    }
    
    //MARK: - Actions
    @objc private func showListButtonTapped() {
        presenter.showList()
    }
    
    //MARK: - Private Methods
    private func initialSetup() {
        setupMap()
        addSubviews()
        setupMapViewConstraints()
    }
    
    private func setupMap() {
        mapView = GMSMapView()
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
    }
    
    private func addSubviews() {
        view.addSubview(mapView)
        mapView.addSubview(listButton)
    }
    
    private func setupMapViewConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func setMapCamera(location: CLLocation?) {
        guard let location = location else { return }
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: 13.0)
        mapView.animate(to: camera)
    }
    
    private func addMarkers(places: [PlacesModel]) {
        places.forEach { place in
            markPlaceOnMap(with: place)
        }
    }
    
    private func markPlaceOnMap(with place: PlacesModel) {
        
        // mark place on map
        let marker = GMSMarker()
        let latitude = place.location.coordinates.latitude
        let longitude = place.location.coordinates.longitude
        let position = CLLocationCoordinate2D(latitude: latitude,
                                              longitude: longitude)
        marker.position = position
        marker.title = place.name
        marker.snippet = place.address
        marker.map = mapView
    }
}

//MARK: -  MapViewProtocol
extension MapViewController: MapViewProtocol {
    func showPlaces(places: [PlacesModel]) {
        self.addMarkers(places: places)
    }
    
    func didFailWithError(error: Error) {
        var errorDescription: String = .empty
        if let error = error as? LocationError {
            errorDescription = error.description
        }
        if let error = error as? NetworkError {
            errorDescription = error.description
        }
        self.showAlert(title: "Error", message: errorDescription)
    }
    
    func didUpdateLocation(location: CLLocation?) {
        self.setMapCamera(location: location)
    }
}
