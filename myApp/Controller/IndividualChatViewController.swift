import UIKit
import MapKit


class IndividualChatViewController: UIViewController, myMapDataDelegate {
    


    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messageType:String?
    var myregion: MKCoordinateRegion?
    func myMapdelegate(region: MKCoordinateRegion) {
        myregion = region
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        message.layer.cornerRadius = message.frame.height/2
        
        //delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //nibs
        tableView.register(UINib(nibName: "SenderMessageCell", bundle: nil), forCellReuseIdentifier: "SenderMessageCell")
        tableView.register(UINib(nibName: "SenderImageVideoCell", bundle: nil), forCellReuseIdentifier: "senderImageVideoCell")
        
        //my delegate functions
        
        
    }
    

    @IBAction func plusPressed(_ sender: UIButton) {
        plusActions()
    }
    @IBAction func sendPressed(_ sender: UIButton){
        
    }
    
    @IBAction func recordPressed(_ sender: UIButton) {
    }
}




// MARK: -  plusButton actions

extension IndividualChatViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func plusActions(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            self.getPhoto(myType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { action in
            self.getPhoto(myType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "File", style: .default, handler: { action in
            //i need to know how to get a file
        }))
        alert.addAction(UIAlertAction(title: "Current Location", style: .default, handler: { action in
            let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "mapVC") as! MapViewController
            mapVC.myMapdelegate = self
            self.navigationController?.pushViewController(mapVC, animated: true)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    func getPhoto(myType: UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = myType
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[.editedImage] as? UIImage{
            //
        }else{
            print("error finding photo or picking it")
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension IndividualChatViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "SenderMessageCell", for: indexPath) as! SenderMessageCell
        cell.message.text = "Hello Reda Hello Reda Hello Reda Hello Reda Hello Reda Hello Reda Hello RedaHello Reda Hello Reda Hello Reda Hello Reda "
        cell.time.text = "10:12 am"*/
        let cell = tableView.dequeueReusableCell(withIdentifier: "senderImageVideoCell", for: indexPath) as! SenderImageVideoCell
        cell.imagesent.image = UIImage(named: "1.jpg")
        return cell
    }
}
