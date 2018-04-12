//
//  LoginViewController.swift
//  Social
//
//  Created by Gayatri Patil on 09/04/18.
//  Copyright © 2018 Gayatri Patil. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
        
    }
    @IBAction func btnSignInTapped(_ sender: Any) {
        
        guard let email = txtFieldEmail.text, let password = txtFieldPassword.text else{
            print("Empty Values")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil{
                
                print("Error Occured")
                self.alert(title: "Error", message: "Invalid Username or Password", actionTitle: "OK")
            }
            else{
                self.performSegue(withIdentifier: "segueHome", sender: self)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       txtFieldPassword.text = ""
        txtFieldEmail.text = ""
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
