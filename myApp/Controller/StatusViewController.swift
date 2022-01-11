import UIKit

protocol StatusDataDelegate{
    func statusData(statusData: String)
}

class StatusViewController: UIViewController{

    var statusDataDelegate:StatusDataDelegate!
    
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var status: UITextView!
    var mystatus = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        status.text = mystatus
        
        save.layer.cornerRadius = save.frame.height/2
    }
    

    @IBAction func savePressed(_ sender: UIButton) {
        statusDataDelegate.statusData(statusData: status.text)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func defaultStatusPressed(_ sender: UIButton){
        
        // mark - this will change automatically the status
        status.text = sender.currentTitle
    }
    
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     //   if let settingsVC = segue.destination as? SettingsViewController {
      //      settingsVC.myStatus = status.text ?? ""
     //   }else{
     //       print("Error creating instance of SettingsViewController")
     //   }
    //}
    
}
