//
//  FirstViewController.swift
//  Social
//
//  Created by Gayatri Patil on 06/04/18.
//  Copyright © 2018 Gayatri Patil. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableviewFeed: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPost.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableviewFeed.dequeueReusableCell(withIdentifier: "feedCell") as! FeedCell
        cell.lblUser.text = listPost[indexPath.row].user
        cell.lblPost.text = listPost[indexPath.row].post
        return cell
    }
    

    var listPost = [Posts]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableviewFeed.estimatedRowHeight = 100
//        tableviewFeed.rowHeight = UITableViewAutomaticDimension

    }

    override func viewWillAppear(_ animated: Bool) {
        FirebaseService.instance.retrievePost { (post) in
            self.listPost = post.reversed()
            self.tableviewFeed.reloadData()
        }
       
    }
    
    
    

    
    
    


}

