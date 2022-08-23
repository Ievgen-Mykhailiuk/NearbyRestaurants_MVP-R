//
//  UIView+Extension.swift
//  GoogleMapTask
//
//  Created by Евгений  on 23/08/2022.
//

import UIKit

extension UIView {
    func makeRound() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height/2
    }
}
