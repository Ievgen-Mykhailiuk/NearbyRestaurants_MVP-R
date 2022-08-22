//
//  UIImageView+Extension.swift
//  GoogleMapTask
//
//  Created by Евгений  on 19/08/2022.
//


import UIKit
import Kingfisher

extension UIImageView {
    func getIconForPlace(iconUrl: String) {
        if let url = URL(string: iconUrl) {
            self.kf.setImage(with: url)
        }
    }
}
