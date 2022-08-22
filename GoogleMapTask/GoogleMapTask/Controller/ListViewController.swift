//
//  DetailsViewController.swift
//  GoogleMapTask
//
//  Created by Евгений  on 18/08/2022.
//

import UIKit

final class ListViewController: UIViewController  {
    
    //MARK: - Properties
    private let tableView = UITableView()
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

    //MARK: - Private methods
    private func initialSetup() {
        navigationItem.title = .navigationTitle
        setupTableView()
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

//MARK: - UITableViewDataSource 
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier,
                                                 for: indexPath) as! PlaceDetailsCell
        let place = places[indexPath.row]
        cell.configure(model: place)
        return cell
    }
}
