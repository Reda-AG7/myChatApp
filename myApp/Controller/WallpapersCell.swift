//
//  WallpapersCell.swift
//  myApp
//
//  Created by Reda Agourram on 1/7/22.
//

import UIKit

class WallpapersCell: UICollectionViewCell {
    
    @IBOutlet weak var wallpaper: UIImageView!
    func updateCell(image: UIImage){
        wallpaper.image = image
    }
}
