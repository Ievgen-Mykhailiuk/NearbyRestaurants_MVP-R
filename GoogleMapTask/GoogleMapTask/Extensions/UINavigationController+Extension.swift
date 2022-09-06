//
//  UINavigationController+Extension.swift
//  GoogleMapTask
//
//  Created by Евгений  on 31/08/2022.
//

import UIKit

extension UINavigationController {
    func pushViewController(_ viewController: UIViewController,
                            animated: Bool,
                            completion: EmptyBlock?) {
        pushViewController(viewController, animated: animated)
        receiveTransitionCompletion(animated: animated, completion: completion)
    }
    
    func popViewController(animated: Bool,
                           completion: EmptyBlock?) {
        popViewController(animated: animated)
        receiveTransitionCompletion(animated: animated, completion: completion)
    }
    
    func popToViewController(_ viewController: UIViewController,
                             animated: Bool,
                             completion: EmptyBlock?) {
        popToViewController(viewController, animated: animated)
        receiveTransitionCompletion(animated: animated, completion: completion)
    }
    
    private func receiveTransitionCompletion(animated: Bool,
                                             completion: EmptyBlock?) {
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion?() }
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion?() }
    }
}
