//
//  DetailsViewController.swift
//  GoogleMapTask
//
//  Created by Евгений  on 18/08/2022.
//

import UIKit

final class ListViewController: UIViewController  {
    
    //MARK: - Properties
    private let tableview = UITableView()
    private let places: [PlacesModel]
    
    //MARK: - Life Cycle
    init(places: [PlacesModel]) {
        self.places = places
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableview.frame = view.bounds
    }
    
    //MARK: - Private methods
    private func initialSetup() {
        navigationItem.title = "List"
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: Constants.cellNibName, bundle: nil),
                           forCellReuseIdentifier: Constants.cellIdentifier)
        view.addSubview(tableview)
    }
}

//MARK: - UITableViewDataSource & UITableViewDelegate
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: Constants.cellIdentifier,
                                                 for: indexPath) as! PlaceDetailsCell
        let place = places[indexPath.row]
        cell.configure(model: place)
        return cell
    }
}
