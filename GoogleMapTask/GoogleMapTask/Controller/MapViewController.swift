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
    private let networkManager = NetworkService()
    private var mapView: GMSMapView!
    private var nearbyPlaces = [PlacesModel]()
    private var currentLocation: CLLocation? {
        didSet {
            setMapCamera(location: currentLocation)
            fetchPlaces(location: currentLocation)
        }
    }
    lazy private var listButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 20, y: 80 , width: 100, height: 30)
        button.backgroundColor = .blue
        button.alpha = 0.6
        button.setTitle("Show list", for: .normal)
        button.makeRound()
        button.addTarget(self,
                         action: #selector(showListButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    //MARK: - Actions
    @objc private func showListButtonTapped() {
        showList()
    }
    
    //MARK: - Private Methods
    private func initialSetup() {
        setupMap()
        addSubviews()
        setupLocationManager()
    }
    
    private func setupMap() {
        mapView = GMSMapView(frame: view.frame)
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
    }
    
    private func addSubviews() {
        view.addSubview(mapView)
        mapView.addSubview(listButton)
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.startUpdateLocation()
    }
  
    private func setMapCamera(location: CLLocation?) {
        guard let location = location else { return }
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: 13.0)
        mapView.animate(to: camera)
    }
    
    private func showList() {
        let rootVC = ListViewController(places: self.nearbyPlaces)
        self.navigationController?.pushViewController(rootVC, animated: true)
    }
    
    private func fetchPlaces(location: CLLocation?) {
        guard let location = location else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        // make network request for places
        networkManager.request(from: .getPlaces(longitude: longitude, latitude: latitude),
                               httpMethod: .get) {
            [weak self] (result: Result<PlacesResults, Error>) in
            switch result {
            case .success(let places):
                DispatchQueue.main.async {
                    
                    // save results to property
                    self?.nearbyPlaces = places.results
                    
                    // add markers to map
                    self?.addMarkers()
                }
            case .failure(let error):
                self?.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    private func addMarkers() {
        self.nearbyPlaces.forEach { place in
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
        marker.map = self.mapView
    }
}

//MARK: - LocationServiceDelegate
extension MapViewController: LocationServiceDelegate {
    func didUpdateLocation(location: CLLocation) {
        self.currentLocation = location
    }
}
