//
//  Router.swift
//  GoogleMapTask
//
//  Created by Евгений  on 23/08/2022.
//

import UIKit

protocol RouterMainProtocol {
    var navigationController: UINavigationController? { get set }
    var builder: BuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMainProtocol {
    func showMapViewController()
    func showListViewController(model: [PlacesModel])
}

final class Router: RouterProtocol {
    
    //MARK: - Properties
    var navigationController: UINavigationController?
    var builder: BuilderProtocol?
    
    //MARK: - Life Cycle
    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    //MARK: - Show methods
    func showMapViewController() {
        if let navigationController = navigationController {
            guard let mapViewController = builder?.createMapModule(router: self) else { return }
            navigationController.viewControllers = [mapViewController]
        }
    }
    
    func showListViewController(model: [PlacesModel]) {
        if let navigationController = navigationController {
            guard let listViewController = builder?.createListModule(model: model,
                                                                     router: self) else { return }
            navigationController.pushViewController(listViewController, animated: true)
        }
    }
}
