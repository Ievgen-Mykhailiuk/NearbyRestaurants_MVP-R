//
//  MapAssembly.swift
//  GoogleMapTask
//
//  Created by Евгений  on 26/08/2022.
//

import UIKit

protocol MapAssembling {
    func createMapModule() -> UIViewController
}

final class MapAssembly: MapAssembling {
    func createMapModule() -> UIViewController {
        let view = MapViewController()
        let networkManager = NetworkService()
        let locationManager = LocationService()
        let router = MapRouter(viewController: view)
        let presenter = MapViewPresenter(view: view,
                                         networkManager: networkManager,
                                         locationManager: locationManager,
                                         router: router)
        view.presenter = presenter
        return view
    }
}
