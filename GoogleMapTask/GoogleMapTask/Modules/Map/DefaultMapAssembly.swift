//
//  DefaultMapAssembly.swift
//  GoogleMapTask
//
//  Created by Евгений  on 26/08/2022.
//

import UIKit

protocol MapAssembly {
    func createMapModule() -> UIViewController
}

final class DefaultMapAssembly: MapAssembly {
    func createMapModule() -> UIViewController {
        let view = MapViewController()
        let networkManager = NetworkService()
        let locationManager = LocationService()
        let router = DefaultMapRouter(viewController: view)
        let presenter = MapViewPresenter(view: view,
                                         networkManager: networkManager,
                                         locationManager: locationManager,
                                         router: router)
        view.presenter = presenter
        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
}
