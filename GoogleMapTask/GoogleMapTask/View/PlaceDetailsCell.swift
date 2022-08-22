//
//  PlaceDetailsCell.swift
//  GoogleMapTask
//
//  Created by Евгений  on 18/08/2022.
//

import UIKit

final class PlaceDetailsCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak private var placeIconImageView: UIImageView!
    @IBOutlet weak private var placeNameLabel: UILabel!
    @IBOutlet weak private var placeAddressLabel: UILabel!
    @IBOutlet weak private var placeRankLabel: UILabel!
    
    //MARK: - Override methods
    override func prepareForReuse() {
        super.prepareForReuse()
        placeIconImageView.image = nil
    }
    
    //MARK: - Cell's content configuration
    func configure(model: PlacesModel) {
        self.placeIconImageView.setImage(imageUrl: model.iconUrl) 
        self.placeNameLabel.text = model.name
        self.placeAddressLabel.text = model.address
        self.placeRankLabel.text = model.rating?.stringValue ?? .empty
    }
}
