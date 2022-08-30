//
//  ListPresenter.swift
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
    private var places: [PlacesModel]
    private let router: ListRouter
    
    //MARK: - Life Cycle
    init(view: ListViewProtocol, places: [PlacesModel], router: ListRouter ) {
        self.view = view
        self.places = places
        self.router = router
    }
    
    //MARK: - Show list method
    func viewDidLoad() {
        self.view?.update(with: places)
    }
}
