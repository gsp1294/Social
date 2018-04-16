//
//  AddGroupViewController.swift
//  Social
//
//  Created by Gayatri Patil on 12/04/18.
//  Copyright © 2018 Gayatri Patil. All rights reserved.
//

import UIKit
import Firebase


class AddMemberCell : UITableViewCell{
    
}

class AddGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var listGroupMembers = [String]()
    @IBOutlet weak var tableEmail: UITableView!
    var listEmail = [String]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listEmail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableEmail.dequeueReusableCell(withIdentifier: "addMemberCell") as! AddMemberCell
        cell.textLabel?.text = listEmail[indexPath.row]
        if listGroupMembers.contains(listEmail[indexPath.row]){
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableEmail.cellForRow(at: indexPath) else {
            return
        }
        let selectedEmail = listEmail[indexPath.row]
        if listGroupMembers.contains(selectedEmail){
                cell.accessoryType = .none
            for (index,value) in listGroupMembers.enumerated(){
                if value == selectedEmail{
                    listGroupMembers.remove(at: index)
                }
            }
            }
            else{
                cell.accessoryType = .checkmark
                listGroupMembers.append(selectedEmail)
            }
        
    }
    

    @IBOutlet weak var btnDone: UIBarButtonItem!
    @IBOutlet weak var txtfieldTitle: UITextField!
    @IBOutlet weak var txtfieldMembers: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtfieldMembers.addTarget(self, action: #selector(searchMembers), for: UIControlEvents.editingChanged)

        // Do any additional setup after loading the view.
    }
    
    @objc func searchMembers(){
        guard !(txtfieldMembers.text?.isEmpty)! else {
            listEmail = []
            tableEmail.reloadData()
            return
        }
        FirebaseService.instance.getEmail(searchString: txtfieldMembers.text!) { (emailArray) in
            self.listEmail = emailArray
            self.tableEmail.reloadData()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        
        if txtfieldTitle.text != "", listGroupMembers.count>0{
            listGroupMembers.append((Auth.auth().currentUser?.email)!)
            FirebaseService.instance.createGroup(withTitle: txtfieldTitle.text!, emails: listGroupMembers) { (groupCreated) in
                if groupCreated {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("Group could not be created. Please try again.")
                }
            }
        }
    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
