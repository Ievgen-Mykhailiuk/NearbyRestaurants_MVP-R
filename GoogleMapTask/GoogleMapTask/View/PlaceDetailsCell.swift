//
//  PlaceDetailsCell.swift
//  GoogleMapTask
//
//  Created by Евгений  on 18/08/2022.
//

import UIKit

class PlaceDetailsCell: UITableViewCell {

    @IBOutlet weak var placeIconImage: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeAddressLabel: UILabel!
    @IBOutlet weak var placeRankLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: PlacesModel) {
        DispatchQueue.main.async {
            self.placeNameLabel.text = model.name
            self.placeAddressLabel.text = model.address
            self.placeRankLabel.text = (String(model.rating ?? 0.0))
            
        }
    }
    
}
