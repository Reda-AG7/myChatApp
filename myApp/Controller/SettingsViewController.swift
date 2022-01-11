import UIKit
import Firebase

class SettingsViewController: UIViewController,StatusDataDelegate,PhotoDataDelegate,SoundDataDelegate,WallpaperDataDelegate {
    
    

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var photo: UIButton!
    @IBOutlet weak var status: UILabel!
    
    // MARK: - my delegates
    
    func statusData(statusData: String) {
        status.text = statusData
    }
    func photoData(image: UIImage) {
        photo.setBackgroundImage(image, for: .normal)
    }
    func soundData(soundId: Int,indexPath: IndexPath) {
        soundiD = soundId
        lastIndexPath = indexPath
    }
    func wallpaperData(indexPath: IndexPath) {
        wallpaperIndexPath = indexPath
    }
    
    var soundiD:Int?
    var myStatus = ""
    var myPhoto:UIImage?
    var myname = ""
    var lastIndexPath:IndexPath?
    var wallpaperIndexPath:IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.layer.cornerRadius = photo.frame.height/2
        photo.layer.masksToBounds = true
        name.text = myname
    }

    @IBAction func editStatusPressed(_ sender: UIButton) {
        let statusVC = storyboard?.instantiateViewController(withIdentifier: "status") as! StatusViewController
        statusVC.statusDataDelegate = self
        statusVC.mystatus = status.text ?? ""
        navigationController?.pushViewController(statusVC, animated: true)
    }
    @IBAction func photoPressed(_ sender:UIButton){
        let photoVC = storyboard?.instantiateViewController(withIdentifier: "photo") as! PhotoViewController
        photoVC.photoDelegate = self
        photoVC.myPhoto = photo.currentBackgroundImage
        navigationController?.pushViewController(photoVC, animated: true)
    }
    @IBAction func sound(_ sender: UIButton) {
        let soundVC = storyboard?.instantiateViewController(withIdentifier: "sound") as! SoundsViewController
        soundVC.soundDelegate = self
        soundVC.oldIndexpath = lastIndexPath
        soundVC.currentIndex = soundiD ?? 1007
        //soundVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(soundVC, animated: true)
    }
    @IBAction func blocked(_ sender: UIButton) {
    }
    @IBAction func wallpaper(_ sender: UIButton) {
        let wallpaperVC = storyboard?.instantiateViewController(withIdentifier: "wallpaper") as! WallpapersViewController
        wallpaperVC.wallpaperDelegate = self
        //wallpaperVC.modalPresentationStyle = .fullScreen
        if wallpaperIndexPath != nil{
            wallpaperVC.oldindexPath = wallpaperIndexPath
        }
        navigationController?.pushViewController(wallpaperVC, animated: true)
    }
    @IBAction func pushNotificationPressed(_ sender: UISwitch) {
    }
    @IBAction func themePressed(_ sender: UISwitch) {
    }
    // MARK: - Signing out
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        signingOutAlert()
    }
    
    func signingOutAlert(){
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to sign out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            do {
                try Auth.auth().signOut()
                print("signed out successfully")
                let startVC = self.storyboard?.instantiateViewController(withIdentifier: "start") as! StartViewController
                startVC.modalPresentationStyle = .fullScreen
                self.present(startVC, animated: true, completion: nil)
                
            } catch let signOutError as NSError {
              print("Error signing out: %@", signOutError)
            }
              
        }))
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}





