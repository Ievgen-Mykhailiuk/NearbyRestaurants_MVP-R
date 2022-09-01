//
//  DefaultListRouter.swift
//  GoogleMapTask
//
//  Created by Евгений  on 26/08/2022.
//

import Foundation

protocol ListRouter {
    func close()
}

final class DefaultListRouter: BaseRouter, ListRouter {
    func close() {
        close(animated: true, completion: nil)
    }
}
