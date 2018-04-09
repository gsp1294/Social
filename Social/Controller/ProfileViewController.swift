//
//  ProfileViewController.swift
//  Social
//
//  Created by Gayatri Patil on 09/04/18.
//  Copyright © 2018 Gayatri Patil. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    
    @IBAction func btnLogOutTapped(_ sender: Any) {
        do{
            try Auth.auth().signOut()
        }
        catch {
            print("error Signing out")
        }
        print("Logged out successfully")
        
        self.performSegue(withIdentifier: "LogInScreen", sender: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
