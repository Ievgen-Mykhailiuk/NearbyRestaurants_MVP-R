//
//  MapRouter.swift
//  GoogleMapTask
//
//  Created by Евгений  on 26/08/2022.
//

import UIKit

protocol MapRouting {
    func showList(places: [PlacesModel])
}

final class MapRouter: BaseRouter, MapRouting {
    func showList(places: [PlacesModel]) {
        let viewController = ListAssembly().createListModule(places: places)
        showViewController(viewController: viewController,
                           isModal: self.viewController.isModal,
                           animated: true)
    }
}



