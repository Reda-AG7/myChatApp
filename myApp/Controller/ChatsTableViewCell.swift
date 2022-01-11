import UIKit

class ChatsTableViewCell: UITableViewCell {

    @IBOutlet weak var read: UIImageView!
    @IBOutlet weak var online: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
 
        //curve photo's corners
        photo.layer.cornerRadius = photo.frame.height/2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
