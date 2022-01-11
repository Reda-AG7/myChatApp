//
//  WallpapersViewController.swift
//  myApp
//
//  Created by Reda Agourram on 1/7/22.
//

import UIKit


protocol WallpaperDataDelegate{
    func wallpaperData(indexPath:IndexPath)
}


class WallpapersViewController: UIViewController {
    var count = 1
    var oldindexPath:IndexPath?
    var currentIndex:Int?

    
    var wallpaperDelegate : WallpaperDataDelegate!

    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        save.layer.cornerRadius = save.frame.height/2
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        currentIndex = count
        
    }
    

    @IBAction func savePressed(_ sender: UIButton) {
        if let safeIndexPath = oldindexPath{
            wallpaperDelegate.wallpaperData(indexPath: safeIndexPath)
        }
        navigationController?.popViewController(animated: true)
    }
    
}

extension WallpapersViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wallpaperCell", for: indexPath) as! WallpapersCell
        if let safeImage = UIImage(named: "\(count).jpg"){
            cell.updateCell(image: safeImage)
            count+=1
            if indexPath == oldindexPath{
                cell.layer.borderWidth = 2
                cell.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }else{
            print("image not found")
        }
        //cell.backgroundColor = .blue
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width*0.45, height: self.view.frame.height * 0.25)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let safeOldindexPath = oldindexPath{
            let cell = collectionView.cellForItem(at: safeOldindexPath) as! WallpapersCell
            cell.layer.borderWidth = 0
            cell.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
        let cell = collectionView.cellForItem(at: indexPath) as! WallpapersCell
        cell.layer.borderWidth = 2
        cell.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        oldindexPath = indexPath
        currentIndex = count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}
