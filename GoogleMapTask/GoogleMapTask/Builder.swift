//
//  Builder.swift
//  GoogleMapTask
//
//  Created by Евгений  on 23/08/2022.
//

import UIKit

protocol BuilderProtocol {
    func createMapModule(router: RouterProtocol) -> UIViewController
    func createListModule(model: [PlacesModel], router: RouterProtocol) -> UIViewController
}

class Builder: BuilderProtocol {
    func createMapModule(router: RouterProtocol) -> UIViewController {
        let view = MapViewController()
        let networkManager = NetworkService()
        let locationManager = LocationService()
        let presenter = MapViewPresenter(view: view,
                                         networkManager: networkManager,
                                         locationManager: locationManager,
                                         router: router)
        view.presenter = presenter
        return view
    }

    func createListModule(model: [PlacesModel], router: RouterProtocol) -> UIViewController {
        let view = ListViewController()
        let presenter = ListViewPresenter(view: view,
                                          model: model,
                                          router: router)
        view.presenter = presenter
        return view
    }
}
