//
//  Extension.swift
//  GoogleMapTask
//
//  Created by Евгений  on 16/08/2022.
//

import Foundation
import UIKit

extension UIViewController {
     func showAlert(title: String, buttonTitle: String, error: Error) {
         let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: buttonTitle, style: .destructive, handler: nil))
         self.present(alert, animated: true, completion: nil)
     }
}
