//
//  SenderMapCell.swift
//  myApp
//
//  Created by Reda Agourram on 1/8/22.
//

import UIKit
import MapKit

class SenderMapCell: UITableViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var sender: UIImageView!
    @IBOutlet weak var map: MKMapView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        map.layer.cornerRadius = map.frame.height*0.2
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
