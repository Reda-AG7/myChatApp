//
//  ChatsViewController.swift
//  myApp
//
//  Created by Reda Agourram on 1/1/22.
//

import UIKit

class ChatsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var search: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
      
    }
    
    @IBAction func archivedPressed(_ sender: UIButton) {
    }
    @IBAction func searchPressed(_ sender: UISearchBar){
        
    }
}


// MARK: - tableView delegate & data source

extension ChatsViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatsCell = tableView.dequeueReusableCell(withIdentifier: "ChatsCell", for: indexPath) as! ChatsTableViewCell
        chatsCell.photo.image = UIImage(systemName: "person.circle.fill")
        chatsCell.name.text = "Reda Agourram"
        chatsCell.message.text = "hello, it's been a long time! where have you been?"
        chatsCell.time.text = "01/01/2022"
        return chatsCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toPrivateChat", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination == IndividualChatViewController(){
            //
        }
    }
    
}
