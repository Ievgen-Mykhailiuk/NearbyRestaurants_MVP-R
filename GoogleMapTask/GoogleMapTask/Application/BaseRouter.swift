//
//  Router.swift
//  GoogleMapTask
//
//  Created by Евгений  on 23/08/2022.
//

import UIKit

protocol BaseModuleRouter: AnyObject {
    func show(viewController: UIViewController,
              isModal: Bool,
              animated: Bool,
              completion: EmptyBlock?)
    
    func close(animated: Bool,
               completion: EmptyBlock?)
    
    func goBack(to viewController: UIViewController,
                animated: Bool,
                completion: EmptyBlock?)
}

class BaseRouter: BaseModuleRouter {
    
    //MARK: - Properties
    private let viewController: UIViewController
    private var navigationController: UINavigationController?  {
        return viewController.navigationController
    }
    
    //MARK: - Life Cycle
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    //MARK: - Base protocol methods
    func show(viewController: UIViewController,
              isModal: Bool,
              animated: Bool,
              completion: EmptyBlock?) {
        let presentingViewController = navigationController ?? self.viewController
        if isModal {
            presentingViewController.present(viewController,
                                             animated: animated,
                                             completion: completion)
        } else {
            navigationController?.pushViewController(viewController,
                                                     animated: animated,
                                                     completion: completion)
        }
    }
    
    func close(animated: Bool,
               completion: EmptyBlock?) {
        if viewController.isModal {
            dismiss(animated: animated, completion: completion)
        } else {
            pop(animated: animated, completion: completion)
        }
    }
    
    func goBack(to viewController: UIViewController,
                animated: Bool,
                completion: EmptyBlock?) {
        navigationController?.popToViewController(viewController,
                                                  animated: animated,
                                                  completion: completion)
    }
    
    private func dismiss(animated: Bool,
                         completion: EmptyBlock?) {
        viewController.dismiss(animated: animated,
                               completion: completion)
    }
    
    private func pop(animated: Bool,
                     completion: EmptyBlock?) {
        navigationController?.popViewController(animated: animated,
                                                completion: completion)
}
}
