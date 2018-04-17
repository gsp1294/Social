//  GroupMessageViewController.swift
//  Social
//
//  Created by Gayatri Patil on 16/04/18.
//  Copyright © 2018 Gayatri Patil. All rights reserved.
//

import UIKit

class GroupMessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var groupData : Group?
    var groupMessages = [Messages]()
    
    @IBOutlet weak var btnSend: UIButton!
    
    @IBOutlet weak var txtFieldMessage: UITextField!
    
    @IBOutlet weak var messageView: UIView!
    
        @IBOutlet weak var tableViewGrpMessage: UITableView!
    @IBAction func btnSendTapped(_ sender: Any) {
        
        if !(txtFieldMessage.text?.isEmpty)! {
            txtFieldMessage.isEnabled = false
            btnSend.isEnabled = false
            FirebaseService.instance.createMessage(MessageData: txtFieldMessage.text!, groupId: (groupData?.groupId)!) { (status) in
                if status {
                    self.txtFieldMessage.text = ""
                    self.txtFieldMessage.isEnabled = true
                    self.btnSend.isEnabled = true
                }
            }
         
    }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewGrpMessage.dequeueReusableCell(withIdentifier: "groupMessageCell", for: indexPath) as! GroupMessageCell
        cell.lblTextMessage.text = groupMessages[indexPath.row].message
        cell.lblUsername.text = groupMessages[indexPath.row].user
        return cell
    }
    

    

    
    override func viewWillAppear(_ animated: Bool) {
        guard let groupData = groupData else {
            return
        }
        FirebaseService.instance.getAllMessages(group: groupData) { (groupArray) in
            self.groupMessages = groupArray
            self.tableViewGrpMessage.reloadData()
            let indexPath = IndexPath(row: self.groupMessages.count-1, section: 0)
            self.tableViewGrpMessage.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
//        if self.groupMessages.count > 0 {
//            self.tableViewGrpMessage.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true)
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewGrpMessage.delegate = self
        tableViewGrpMessage.dataSource = self
        
        messageView.keyboardToggle()
        
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnBackTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
