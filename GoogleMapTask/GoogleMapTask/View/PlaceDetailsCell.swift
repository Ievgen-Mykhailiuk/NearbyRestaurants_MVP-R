//
//  PlaceDetailsCell.swift
//  GoogleMapTask
//
//  Created by Евгений  on 18/08/2022.
//

import UIKit

final class PlaceDetailsCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var placeIconImage: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeAddressLabel: UILabel!
    @IBOutlet weak var placeRankLabel: UILabel!
    
    //MARK: - Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    //MARK: - Cell's content configuration
    func configure(model: PlacesModel) {
        DispatchQueue.main.async {
            self.placeIconImage.getIconForPlace(iconUrl: model.iconUrl)
            self.placeNameLabel.text = model.name
            self.placeAddressLabel.text = model.address
            self.placeRankLabel.text = (String(model.rating ?? 0.0))
        }
    }
}
