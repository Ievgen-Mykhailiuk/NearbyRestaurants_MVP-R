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
    
    //MARK: - Cell's content configuration
    func configure(place: PlacesModel) {
        placeIconImageView.image = nil
        placeIconImageView.setImage(imageUrl: place.iconUrl)
        placeNameLabel.text = place.name
        placeAddressLabel.text = place.address
        placeRankLabel.text = place.rating?.stringValue ?? .empty
    }
}
