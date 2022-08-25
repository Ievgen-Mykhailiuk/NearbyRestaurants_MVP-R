//
//  MapPresenter.swift
//  GoogleMapTask
//
//  Created by Евгений  on 23/08/2022.
//

import Foundation
import CoreLocation

protocol MapViewPresenterProtocol: AnyObject {
    init(view: MapViewProtocol,
         networkManager: NetworkServiceProtocol,
         locationManager: LocationService,
         router: RouterProtocol)

    func didTapOnShowListButton()
    func startUpdatingLocation()
}

final class MapViewPresenter {
   
    //MARK: - Properties
    private weak var view: MapViewProtocol?
    private let locationManager: LocationService
    private let networkManager: NetworkServiceProtocol
    private let router: RouterProtocol
    var model = [PlacesModel]()
    var currentLocation: CLLocation?  {
        didSet {
            fetchPlaces(location: currentLocation)
        }
    }
    
    //MARK: - Life Cycle
    required init(view: MapViewProtocol,
                  networkManager: NetworkServiceProtocol,
                  locationManager: LocationService,
                  router: RouterProtocol) {
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
            [weak self] (result: Result<PlacesResults, Error>) in
            switch result {
            case .success(let places):
                DispatchQueue.main.async {
                    self?.model = places.results
                    self?.view?.didShowPlaces(model: places.results)
                }
            case .failure(let error):
                self?.view?.didFailWithError(error: error)
            }
        }
    }
}

//MARK: - MapViewPresenterProtocol
extension MapViewPresenter: MapViewPresenterProtocol {
    func startUpdatingLocation() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func didTapOnShowListButton() {
        router.showListViewController(model: model)
    }
}

//MARK: - LocationServiceDelegate
extension MapViewPresenter: LocationServiceDelegate {
    func didUpdateLocation(location: CLLocation?) {
        self.currentLocation = location
        self.view?.didUpdateLocation(location: currentLocation)
    }
    
    func didFailWithError(error: Error) {
        self.view?.didFailWithError(error: error)
    }
}
