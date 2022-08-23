//
//  UIView+Extension.swift
//  GoogleMapTask
//
//  Created by Евгений  on 23/08/2022.
//

import UIKit

extension UIView {
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            self.layer.cornerRadius = newValue
        }
    }
    
    func makeRounded() {
        cornerRadius = self.frame.height/2
    }
}
