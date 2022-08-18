//
//  DetailsViewController.swift
//  GoogleMapTask
//
//  Created by Евгений  on 18/08/2022.
//

import UIKit

class DetailsViewController: UIViewController  {
    
    let tableview = UITableView()
    var places: [PlacesModel]
    
    init(places: [PlacesModel]) {
        self.places = places
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        self.tableview.register(UINib(nibName: Constants.classNibName, bundle: nil), forCellReuseIdentifier: Constants.detailCellIdentifier)
        view.addSubview(tableview)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableview.frame = view.bounds
    }
}

extension DetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: Constants.detailCellIdentifier, for: indexPath) as! PlaceDetailsCell
        let place = places[indexPath.row]
        cell.configure(model: place)
        return cell
    }
}

extension DetailsViewController: UITableViewDelegate {
    
}
