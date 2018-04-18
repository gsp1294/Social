//
//  ProfileViewController.swift
//  Social
//
//  Created by Gayatri Patil on 09/04/18.
//  Copyright © 2018 Gayatri Patil. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablePosts.dequeueReusableCell(withIdentifier: "feedCell") as! FeedCell
        cell.lblUser.sizeToFit()
        cell.lblPost.sizeToFit()
        cell.lblUser.text = listPost[indexPath.row].user
        cell.lblPost.text = listPost[indexPath.row].post
        return cell
    }
    
    var listPost = [Posts]()
    
    @IBOutlet weak var tablePosts: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var lblProfileName: UILabel!
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
        lblProfileName.text = Auth.auth().currentUser?.email
        tablePosts.delegate = self
        tablePosts.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FirebaseService.instance.retrievePost { (post) in
            var usersFeed = [Posts]()
            for elements in post.reversed() {
                if elements.user == Auth.auth().currentUser?.email {
                    usersFeed.append(elements)
                }
            }
            self.listPost = usersFeed
            self.configureTableView()
            self.tablePosts.reloadData()
        }
    }
    func configureTableView(){
        tablePosts.estimatedRowHeight = 100
        tablePosts.rowHeight = UITableViewAutomaticDimension
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
