//
//  UIApplication+Extension.swift
//  GoogleMapTask
//
//  Created by Евгений  on 31/08/2022.
//

import UIKit

extension UIApplication {
    static func openSettings() {
        if let url = URL(string:UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }

    static var keyWindowViewController: UIViewController? {
        return UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController
    }
}
