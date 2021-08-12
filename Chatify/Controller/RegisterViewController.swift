//
//  RegisterViewController.swift
//  Chatify
//
//  Created by Dipika Kansara on 11/8/21.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet var emailTexfield:UITextField!
    @IBOutlet var passwordTexfield:UITextField!

    @IBOutlet var alertLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertLbl.isHidden = true

      
    }
    
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        
        if let email = emailTexfield.text, let password = passwordTexfield.text
        {
            Auth.auth().createUser(withEmail: email, password: password)
            {
                authResult, error in
                
                if let e = error{
                    self.alertLbl.isHidden = false
                    self.alertLbl.text = e.localizedDescription
                    print(e.localizedDescription)
                }
                else{
                    self.alertLbl.isHidden = true
                    self.performSegue(withIdentifier: Constants.registerSegue, sender: self)
                }
          
            }
        }
        
       
    }
    
    


}
