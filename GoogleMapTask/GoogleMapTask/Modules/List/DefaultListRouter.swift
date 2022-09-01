//
//  DefaultListRouter.swift
//  GoogleMapTask
//
//  Created by Евгений  on 26/08/2022.
//

import Foundation

protocol ListRouter {
    func closeList()
}

final class DefaultListRouter: BaseRouter, ListRouter {
    func closeList() {
        close(animated: true, completion: nil)
    }
}
