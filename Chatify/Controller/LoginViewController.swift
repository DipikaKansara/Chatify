//
//  LoginViewController.swift
//  Chatify
//
//  Created by Dipika Kansara on 11/8/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
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
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
              guard let strongSelf = self else { return }
                
                
                if let e = error{
                    
                    self?.alertLbl.isHidden = false
                    self?.alertLbl.text = e.localizedDescription
                    print(e)
                }
                else{
                    self?.alertLbl.isHidden = true
                    
                    self?.performSegue(withIdentifier: Constants.LoginSegue, sender: self)
                }
              
            }
              
               
          
            }
        }
        
       
    }


