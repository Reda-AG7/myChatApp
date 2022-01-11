//
//  SenderImageVideoCell.swift
//  myApp
//
//  Created by Reda Agourram on 1/8/22.
//

import UIKit

class SenderImageVideoCell: UITableViewCell {

    
    @IBOutlet weak var imagesent: UIImageView!
    @IBOutlet weak var sender: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imagesent.layer.cornerRadius = imagesent.frame.height*0.2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
