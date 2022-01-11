import UIKit

protocol PhotoDataDelegate{
    func photoData(image : UIImage)
}

class PhotoViewController: UIViewController {
    
    var photoDelegate : PhotoDataDelegate!
    
    @IBOutlet weak var photo: UIImageView!
    
    var myPhoto:UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = myPhoto ?? UIImage(systemName: "person.circle.fill")
       
    }
    
    @IBAction func editPressed(_ sender: UIButton) {
        showPhoto()
        
    }
    @IBAction func savePressed(_ sender: UIButton) {
        photoDelegate.photoData(image: photo.image!)
        navigationController?.popViewController(animated: true)
    }
    
}


// MARK: - update photo
extension PhotoViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func showPhoto(){
        let alert = UIAlertController(title: "get photo", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            self.getPhoto(myType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { action in
            self.getPhoto(myType: .photoLibrary)
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
            photo.image = image
        }else{
            print("error finding photo or picking it")
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
