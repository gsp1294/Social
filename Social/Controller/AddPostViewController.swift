//
//  AddPostViewController.swift
//  Social
//
//  Created by Gayatri Patil on 12/04/18.
//  Copyright © 2018 Gayatri Patil. All rights reserved.
//

import UIKit
import Firebase
class AddPostViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var txtviewPost: UITextView!

    @IBOutlet weak var btnPost: UIButton!
    @IBAction func btnPostTapped(_ sender: Any) {
        if txtviewPost.text.isEmpty || txtviewPost.text == "Say Something..."{
            alert(title: "Enter Post", message: nil, actionTitle: "OK")
            return}
        let postData = ["user" : Auth.auth().currentUser!.email!, "post" : txtviewPost.text! ]
        FirebaseService.instance.createPost(PostData: postData)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblUser.text = Auth.auth().currentUser?.email
        txtviewPost.delegate = self
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        btnPost.keyboardToggle()
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
