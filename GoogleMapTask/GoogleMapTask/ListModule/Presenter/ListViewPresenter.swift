//
//  ListPresenter.swift
//  GoogleMapTask
//
//  Created by Евгений  on 23/08/2022.
//

import Foundation

protocol ListViewPresenterProtocol: AnyObject   {
    init(view: ListViewProtocol,
         model: [PlacesModel],
         router: RouterProtocol)
    
    func showListOfPlaces()
}

final class ListViewPresenter: ListViewPresenterProtocol {
    
    //MARK: - Properties
    private weak var view: ListViewProtocol?
    var model: [PlacesModel]
    private let router: RouterProtocol
    
    //MARK: - Life Cycle
    required init(view: ListViewProtocol, model: [PlacesModel], router: RouterProtocol ) {
        self.view = view
        self.model = model
        self.router = router
    }
    
    //MARK: - Show list method
    func showListOfPlaces() {
        self.view?.didUpdatePlaces(model: model)
    }
}
