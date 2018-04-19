//  GroupMessageViewController.swift
//  Social
//
//  Created by Gayatri Patil on 16/04/18.
//  Copyright © 2018 Gayatri Patil. All rights reserved.
//

import UIKit

class GroupMessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var contentview: UIView!
    var groupData : Group?
    var groupMessages = [Messages]()
    
    @IBOutlet weak var btnSend: UIButton!
    
    @IBOutlet weak var txtFieldMessage: UITextField!
    
    @IBOutlet weak var messageView: UIView!
    
        @IBOutlet weak var tableViewGrpMessage: UITableView!
    @IBAction func btnSendTapped(_ sender: Any) {
        
        if !(txtFieldMessage.text?.checkIfEmpty())! {
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
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return UITableViewAutomaticDimension
//    }
    
    func configureTableView(){
        tableViewGrpMessage.rowHeight = UITableViewAutomaticDimension
        tableViewGrpMessage.estimatedRowHeight = 120.0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewGrpMessage.dequeueReusableCell(withIdentifier: "groupMessageCell", for: indexPath) as! GroupMessageCell
        cell.lblUsername.sizeToFit()
        cell.lblTextMessage.text = groupMessages[indexPath.row].message
        cell.lblTextMessage.sizeToFit()
        cell.lblUsername.text = groupMessages[indexPath.row].user
        cell.lblTextMessage.layoutIfNeeded()
        cell.lblUsername.layoutIfNeeded()
        return cell
    }
    

    

    
    override func viewWillAppear(_ animated: Bool) {
        guard let groupData = groupData else {
            return
        }
        FirebaseService.instance.getAllMessages(group: groupData) { (groupArray) in
            self.groupMessages = groupArray
            self.configureTableView()
            self.tableViewGrpMessage.reloadData()
            let indexPath = IndexPath(row: self.groupMessages.count-1, section: 0)
            self.tableViewGrpMessage.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
//        if self.groupMessages.count > 0 {
//            self.tableViewGrpMessage.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true)
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewGrpMessage.delegate = self
        tableViewGrpMessage.dataSource = self
           tableViewGrpMessage.estimatedRowHeight = 100
        //messageView.keyboardToggle()
        contentview.keyboardToggle()
        
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

