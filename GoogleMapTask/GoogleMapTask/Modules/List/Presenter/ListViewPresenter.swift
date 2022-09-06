//
//  ListViewPresenter.swift
//  GoogleMapTask
//
//  Created by Евгений  on 23/08/2022.
//

import Foundation

protocol ListViewPresenterProtocol: AnyObject   {
    func viewDidLoad()
}

final class ListViewPresenter: ListViewPresenterProtocol {
    
    //MARK: - Properties
    private weak var view: ListViewProtocol?
    private let places: [PlacesModel]
    private let router: DefaultListRouter
    
    //MARK: - Life Cycle
    init(view: ListViewProtocol, places: [PlacesModel], router: DefaultListRouter ) {
        self.view = view
        self.places = places
        self.router = router
    }
    
    //MARK: - Update view method
    func viewDidLoad() {
        self.view?.update(with: places)
    }
}
