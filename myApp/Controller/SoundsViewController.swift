import UIKit
import AVFoundation

protocol SoundDataDelegate{
    func soundData(soundId: Int,indexPath :IndexPath)
}

class SoundsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var soundDelegate:SoundDataDelegate!
    
    var count = 1007
    var oldIndexpath:IndexPath?
    var currentIndex :Int?
    
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        currentIndex = count
        
        save.layer.cornerRadius = save.frame.height/2
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "soundCell", for: indexPath) as! SoundsCell
        cell.soundName.text = "\(count)"
        if indexPath != oldIndexpath{
            cell.check.isHidden = true
        }
        count+=1
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let oldPath = oldIndexpath{
            let cell = tableView.cellForRow(at: oldPath) as! SoundsCell
            cell.check.isHidden = true
        }
        let cell = tableView.cellForRow(at: indexPath) as! SoundsCell
        cell.check.isHidden = false
        AudioServicesPlaySystemSound(SystemSoundID(indexPath.row+1007))
        oldIndexpath = indexPath
        currentIndex = indexPath.row+1007
    }

    @IBAction func savePressed(_ sender: UIButton) {
        soundDelegate.soundData(soundId: currentIndex ?? 0,indexPath: oldIndexpath!)
        navigationController?.popViewController(animated: true)
    }
}
