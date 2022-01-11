import UIKit
import Firebase

class StartViewController: UIViewController{
//Constraints
    @IBOutlet weak var buttonTC: NSLayoutConstraint!
    @IBOutlet weak var emailTC: NSLayoutConstraint!
    var oldEmailTC:NSLayoutConstraint!
    var oldButtonTC:NSLayoutConstraint!
    var newEmailTC:NSLayoutConstraint!
    var newButtonTC:NSLayoutConstraint!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var cpassword: UITextField!
    @IBOutlet weak var photo: UIButton!
    @IBOutlet weak var fpassword: UIButton!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //- Delegates:
        email.delegate = self
        password.delegate = self
        cpassword.delegate = self
        
        //- Default page is create account
        segmentControl.selectedSegmentIndex = 1
        fpassword.isHidden = true
        
        //-Constraints:
        oldEmailTC = emailTC
        oldButtonTC = buttonTC
        newEmailTC = NSLayoutConstraint(item: email!, attribute: .top, relatedBy: .equal, toItem: segmentControl, attribute: .bottom, multiplier: 1, constant: 20)
        newButtonTC = NSLayoutConstraint(item: button!, attribute: .top, relatedBy: .equal, toItem: password, attribute: .bottom, multiplier: 1, constant: 20)
        
        //curve the image corners
        photo.layer.cornerRadius = photo.frame.height/2
        photo.layer.masksToBounds = true
    }


    @IBAction func buttonPressed(_ sender: UIButton) {
        if(segmentControl.selectedSegmentIndex == 0){
            if let email = email.text, let password = password.text{
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let e = error{
                        print("Error \(e)")
                    }else{
                        print("Signed in successfully")
                        self.performSegue(withIdentifier: "toChats", sender: self)
                    }
                }
            }
        }else{
            if let email = email.text, let password = password.text{
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        print("error \(e)")
                    }else{
                        print("registered successfully")
                        self.performSegue(withIdentifier: "toChats", sender: self)
                    }
                }
            }
        }
    }
    // MARK: - segment control
    
    @IBAction func segmentControlPressed(_ sender: UISegmentedControl) {
        if(segmentControl.selectedSegmentIndex == 1){
            title = "Create Account"
            button.setTitle("Create Account", for: .normal)
            activateConstraints(fpass: true, cpass: false, ph: false, eTC: oldEmailTC, bTC: oldButtonTC)
        }else{
            title = "Login"
            button.setTitle("Login", for: .normal)
            activateConstraints(fpass: false, cpass: true, ph: true, eTC: newEmailTC, bTC: newButtonTC)
        }
    }

    @IBAction func photoPressed(_ sender: UIButton) {
        showPhoto();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    @IBAction func fpasswordPressed(_ sender: UIButton) {
        
    }
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChats"{
            let settingsVC = SettingsViewController()
            settingsVC.myname = email.text ?? ""
        }
    }
    
}



// MARK: - Image picker controller

extension StartViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func showPhoto(){
        let alert = UIAlertController(title: "Get Photo", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { ActionHandler in
            self.pickPhoto(myType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { ActionHandler in
            self.pickPhoto(myType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func pickPhoto(myType : UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = myType
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[.editedImage] as? UIImage{
            photo.setBackgroundImage(image, for: .normal)
        }
    }
}

// MARK: - UITextfield controller

extension StartViewController : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //textField.layer.borderColor = UIColor.white.cgColor
        //textField.placeholder = "\(textField.placeholder!)";
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(segmentControl.selectedSegmentIndex == 0){
            if(textField == email){
                password.becomeFirstResponder()
            }else{
                checkTextField(choice: 2)
                self.buttonPressed(UIButton())
            }
        }else{
            if(textField == email){
                password.becomeFirstResponder()
            }else if(textField == password){
                cpassword.becomeFirstResponder()
            }else{
                checkTextField(choice: 3)
                self.buttonPressed(UIButton())
            }
        }
        return true
    }
    func checkTextField(choice:Int){
        for i in 1...choice{
            if let tempTextField = view.viewWithTag(i) as? UITextField{
                if(tempTextField.text == ""){
                    textFieldAlert(textField: tempTextField)
                }
            }
        }
    }
    func textFieldAlert(textField:UITextField){
        let alert = UIAlertController(title: "Error", message: "\(textField.placeholder ?? "box") left empty", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            //textField.layer.borderWidth = 1.5
            //textField.layer.borderColor = UIColor.red.cgColor
            //textField.placeholder = "\(textField.placeholder ?? "box") left empty";
            textField.becomeFirstResponder()
        }))
        present(alert, animated: true, completion: nil)
    }
    func activateConstraints(fpass:Bool,cpass:Bool,ph:Bool,eTC:NSLayoutConstraint,bTC:NSLayoutConstraint){
        fpassword.isHidden = fpass
        cpassword.isHidden = cpass
        photo.isHidden = ph
        emailTC.isActive = false
        buttonTC.isActive = false
        emailTC = eTC
        buttonTC = bTC
        emailTC.isActive = true
        buttonTC.isActive = true
        email.text = "";password.text = "";cpassword.text = "";photo.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        view.updateConstraints()
    }
    func unwindToStart(_ sender: UIStoryboardSegue){
        
    }
}
