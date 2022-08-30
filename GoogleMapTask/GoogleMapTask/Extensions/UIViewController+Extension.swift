//
//  Extension.swift
//  GoogleMapTask
//
//  Created by Евгений  on 16/08/2022.
//

import UIKit

extension UIViewController {
    func showAlert(title: String?,
                   message: String?,
                   actions: [UIAlertAction]? = nil) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        if let actions = actions {
            for action in actions {
                alert.addAction(action)
            }
        } else {
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: nil))
        }
        DispatchQueue.main.async {
            self.present(alert,
                         animated: true,
                         completion: nil)
        }
    }
}

extension UIViewController {
    var isModal: Bool {
        return presentingViewController != nil ||
        navigationController?.presentingViewController != nil
    }
}
