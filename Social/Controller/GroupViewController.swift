//
//  SecondViewController.swift
//  Social
//
//  Created by Gayatri Patil on 06/04/18.
//  Copyright © 2018 Gayatri Patil. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var groupsArray = [Group]()
    
    @IBOutlet weak var tableViewGroups: UITableView!
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewGroups.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupCell
        cell.lblGroupTitle.text = groupsArray[indexPath.row].groupTitle
        cell.lblGroupMemberCount.text = "\(groupsArray[indexPath.row].memberCount) members"
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FirebaseService.instance.getAllGroups {
            (returnedGroupsArray) in
            self.groupsArray = returnedGroupsArray
            self.tableViewGroups.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewGroups.delegate = self
        tableViewGroups.dataSource = self
    }
    
    
}




