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
        

    }

    override func viewWillAppear(_ animated: Bool) {
        retrievePost { (post) in
            self.listPost = post.reversed()
            self.tableviewFeed.reloadData()
        }
       
    }
    
    func retrievePost (completion : @escaping (_ listPost : [Posts]) -> ()){
          var list = [Posts]()
        FirebaseService.instance.feebBase.observe(DataEventType.childAdded) { (FeedSnapshot) in
        let postData = FeedSnapshot.value as! Dictionary<String,String>

                let objPost = Posts()
            
                objPost.user = postData["user"]
                objPost.post = postData["post"]
                list.append(objPost)
                completion(list)
            
        }
        
        
    }


}

