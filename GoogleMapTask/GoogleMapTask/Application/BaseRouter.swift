//
//  Router.swift
//  GoogleMapTask
//
//  Created by Евгений  on 23/08/2022.
//

import UIKit

protocol BaseModuleRouter: AnyObject {
    func showViewController(viewController: UIViewController,
                            isModal: Bool,
                            animated: Bool)
    
    func closeViewController(viewController: UIViewController,
                             animated: Bool)
    
    func goBackToViewController(viewController: UIViewController,
                                animated: Bool)
}

class BaseRouter: BaseModuleRouter {
    
    //MARK: - Properties
    let viewController: UIViewController
    var navigationController: UINavigationController?  {
        return viewController.navigationController
    }
    
    //MARK: - Life Cycle
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    //MARK: - Methods
    func showViewController(viewController: UIViewController,
                            isModal: Bool,
                            animated: Bool) {
        let presentingViewController = navigationController ?? viewController
        if isModal {
            presentingViewController.present(viewController, animated: animated)
        } else {
            navigationController?.pushViewController(viewController, animated: animated)
        }
    }
    
    func closeViewController(viewController: UIViewController,
                             animated: Bool) {
        let presentingViewController = navigationController ?? viewController
        if viewController.isModal {
            presentingViewController.dismiss(animated: animated)
        } else {
            navigationController?.popViewController(animated: animated)
        }
    }
    
    func goBackToViewController(viewController: UIViewController,
                                animated: Bool) {
        navigationController?.popToViewController(viewController,
                                                  animated: animated)
    }
}
