//
//  DefaultMapRouter.swift
//  GoogleMapTask
//
//  Created by Евгений  on 26/08/2022.
//

import UIKit

protocol MapRouter {
    func showList(places: [PlacesModel])
}

final class DefaultMapRouter: BaseRouter, MapRouter {
    func showList(places: [PlacesModel]) {
        let viewController = DefaultListAssembly().createListModule(places: places)
        show(viewController: viewController,
             isModal: false,
             animated: true,
             completion: nil)
    }
}



