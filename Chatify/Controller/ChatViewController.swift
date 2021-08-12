//
//  ChatViewController.swift
//  Chatify
//
//  Created by Dipika Kansara on 11/8/21.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

class ChatViewController: UIViewController {

    @IBOutlet var logOffBtn: UIBarButtonItem!
    @IBOutlet var chatTable:UITableView!
    
    @IBOutlet var messageTxtfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Messagedata] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
       
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
        imageView.contentMode = .center
        let image = UIImage(named: "main logo")
            imageView.image = image
            navigationItem.titleView = imageView
        
        chatTable.delegate = self
        chatTable.dataSource = self
        
        
        
        
        
        chatTable.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        loadMessages()
    }
    
    
    func loadMessages(){
        db.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.dateField)
            .addSnapshotListener { (querySnapshot, err) in
            self.messages = []
            
            if let err = err {
                print("Error getting data: \(err)")
            }
            else{
                if let snapshotDoc =  querySnapshot?.documents{
                    for document in snapshotDoc {
                        let data = document.data()
                        if  let messagesender = data[Constants.FStore.senderField] as? String, let messageBody = data[Constants.FStore.bodyField] as? String{
                            let newmessage = Messagedata(sender: messagesender, body: messageBody)
                            self.messages.append(newmessage)
                            
                            DispatchQueue.main.async {
                                self.chatTable.reloadData()
                                let indexpath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.chatTable.scrollToRow(at: indexpath, at: .top, animated: true)
                            }
                        }
                    }
                }
    }
        }
    }
    

    
    
    @IBAction func sendbtnPressed(_ sender: UIButton){
        if let medssageBody = messageTxtfield.text, let messageSender = Auth.auth().currentUser?.email {
           
            db.collection(Constants.FStore.collectionName).addDocument(data: [
                Constants.FStore.senderField: messageSender,
                Constants.FStore.bodyField: medssageBody,
                Constants.FStore.dateField: Date().timeIntervalSince1970
            ]) { err in
                if let e = err {
                    print("issue: \(e)")
                } else {
                    print("Success")
                    DispatchQueue.main.async {
                        self.messageTxtfield.text = ""
                    }
                   
                }
            }

        }
    }
    

    @IBAction func logOffBtnPressed(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
    }
        catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
    }
      
    }
}
// MARK: - Table view Data sorce
extension ChatViewController:  UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
        
        cell.MessageLbl.text = messages[indexPath.row].body
        
        if message.sender == Auth.auth().currentUser?.email{
            cell.leftImg.isHidden = true
            cell.rightImg.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
            cell.MessageLbl.textColor = UIColor(named: Constants.BrandColors.purple)
        }
        else{
            cell.leftImg.isHidden = false
            cell.rightImg.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.lighBlue)
            cell.MessageLbl.textColor = UIColor(named: Constants.BrandColors.blue)
        }
       
     
        
        return cell
    }
    
    
}

// MARK: - Table view Delegate
extension ChatViewController:  UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }

}



