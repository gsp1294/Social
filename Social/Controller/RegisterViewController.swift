//
//  RegisterViewController.swift
//  Social
//
//  Created by Gayatri Patil on 09/04/18.
//  Copyright © 2018 Gayatri Patil. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var txtFieldEmail: UITextField!
    
    @IBOutlet weak var txtfieldPassword: UITextField!
    
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtfieldPassword.text = ""
        txtFieldEmail.text = ""
    }
    
    
    @IBAction func btnRegisterTapped(_ sender: UIButton) {
        guard let email = txtFieldEmail.text, let password = txtfieldPassword.text else{
            print("Fields not entered")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user, error == nil else {
                print(error as Any)
                 self.alert(title: "Error", message: "Invalid Username or Password", actionTitle: "OK")
                return
            }
            let userData = ["userID" : user.providerID, "email" : user.email!]
            FirebaseService.instance.createUser(userID: user.uid, userData: userData)
            self.performSegue(withIdentifier: "segueHome", sender: self)
            
        }
        
    }
    
}
