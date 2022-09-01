//
//  MapViewPresenter.swift
//  GoogleMapTask
//
//  Created by Евгений  on 23/08/2022.
//

import Foundation
import CoreLocation

protocol MapViewPresenterProtocol: AnyObject {
    func showList()
    func viewDidLoad()
}

final class MapViewPresenter {
    
    //MARK: - Properties
    private weak var view: MapViewProtocol?
    private let locationManager: LocationService
    private let networkManager: NetworkServiceProtocol
    private let router: DefaultMapRouter
    private var places = [PlacesModel]()
    private var currentLocation: CLLocation?  {
        didSet {
            fetchPlaces(location: currentLocation)
        }
    }
    
    //MARK: - Life Cycle
    init(view: MapViewProtocol,
         networkManager: NetworkServiceProtocol,
         locationManager: LocationService,
         router: DefaultMapRouter) {
        self.view = view
        self.networkManager = networkManager
        self.router = router
        self.locationManager = locationManager
    }
    
    //MARK: - Private methods
    private func fetchPlaces(location: CLLocation?) {
        guard let location = location else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        // make network request for places
        networkManager.request(from: .getPlaces(longitude: longitude, latitude: latitude),
                               httpMethod: .get) {
            [weak self] (result: Result<PlacesResults, NetworkError>) in
            switch result {
            case .success(let places):
                DispatchQueue.main.async {
                    self?.places = places.results
                    self?.view?.showPlaces(places.results)
                }
            case .failure(let error):
                self?.view?.didFailWithError(error: error.rawValue)
            }
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
    }
}

//MARK: - MapViewPresenterProtocol
extension MapViewPresenter: MapViewPresenterProtocol {
    func viewDidLoad() {
        setupLocationManager()
    }
    
    func showList() {
        router.showList(places: places)
    }
}

//MARK: - LocationServiceDelegate
extension MapViewPresenter: LocationServiceDelegate {
    func didUpdateLocation(location: CLLocation?) {
        self.currentLocation = location
        self.view?.didUpdateLocation(location: currentLocation)
    }
    
    func didFailWithError(error: String) {
        self.view?.didFailWithError(error: error)
    }
}
