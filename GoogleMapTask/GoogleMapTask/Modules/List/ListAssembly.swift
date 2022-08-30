//
//  ListAssembly.swift
//  GoogleMapTask
//
//  Created by Евгений  on 26/08/2022.
//

import UIKit

protocol ListAssembling {
    func createListModule(places: [PlacesModel]) -> UIViewController
}

final class ListAssembly: ListAssembling {
    func createListModule(places: [PlacesModel]) -> UIViewController {
        let view = ListViewController()
        let router = ListRouter(viewController: view)
        let presenter = ListViewPresenter(view: view,
                                          places: places,
                                          router: router)
        view.presenter = presenter
        return view
    }
}
