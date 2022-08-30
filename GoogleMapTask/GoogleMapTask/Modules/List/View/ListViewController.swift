//
//  DetailsViewController.swift
//  GoogleMapTask
//
//  Created by Евгений  on 18/08/2022.
//

import UIKit

protocol ListViewProtocol: AnyObject {
    func update(with places: [PlacesModel])
}

final class ListViewController: UIViewController  {
    
    //MARK: - Properties
    private var tableView: UITableView!
    private let cellIdentifier = String(describing: PlaceDetailsCell.self)
    var presenter: ListViewPresenterProtocol!
    private var places = [PlacesModel]()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        presenter.viewDidLoad()
    }

    //MARK: - Private methods
    private func initialSetup() {
        navigationItem.title = .navigationTitle
        setupTableView()
        view.addSubview(tableView)
        setupTableViewConstraints()
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: cellIdentifier)
    }
    
    private func setupTableViewConstraints() {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath) as! PlaceDetailsCell
        let place = places[indexPath.row]
        cell.configure(place: place)
        return cell
    }
}

//MARK: - ListViewProtocol
extension ListViewController: ListViewProtocol {
    func update(with places: [PlacesModel]) {
        self.places = places
        tableView.reloadData()
    }
}

//MARK: - Private extension String
private extension String {
    static let navigationTitle = "List"
}
