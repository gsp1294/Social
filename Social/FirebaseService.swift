//
//  FirebaseService.swift
//  Social
//
//  Created by Gayatri Patil on 11/04/18.
//  Copyright © 2018 Gayatri Patil. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class FirebaseService {
    
    static let instance = FirebaseService()
    
    var usersBase = DB_BASE.child("users")
    var groupBase = DB_BASE.child("groups")
    var feebBase = DB_BASE.child("feeds")
    
    
    func createUser ( userID : String , userData : Dictionary<String,Any>){
        usersBase.child(userID).updateChildValues(userData)
    }
    
    func createPost(PostData: Dictionary<String , Any>){
        
        feebBase.childByAutoId().updateChildValues(PostData)
        
    }
    
     func createMessage(MessageData: String, groupId: String, sendComplete: @escaping (_ status: Bool) -> ()) {
        groupBase.child(groupId).child("messages").childByAutoId().updateChildValues(["messageText": MessageData, "email": Auth.auth().currentUser!.email!])
            sendComplete(true)
    }
    
    
    func getEmail(searchString : String, completion: @escaping ( _ emails : [String]) -> ()){
        var emailList = [String]()
        usersBase.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if email.contains(searchString) == true && email != Auth.auth().currentUser?.email {
                    emailList.append(email)
                }
            }
            completion(emailList)
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
    
    
    
    func getAllMessages(group: Group, handler: @escaping (_ messagesArray: [Messages]) -> ()) {
        var groupMessageArray = [Messages]()
        groupBase.child(group.groupId).child("messages").observe(.childAdded) { (groupMessageSnapshot) in
            guard let groupMessage = groupMessageSnapshot.value as? Dictionary<String,String>
                else { return }
           // for groupMessage in groupMessageSnapshot {
                let message = groupMessage["messageText"]
                let email = groupMessage["email"]
                let groupMessageObj = Messages(user: email!, message : message!)
                groupMessageArray.append(groupMessageObj)
          //  }
            handler(groupMessageArray)
        }
    }
    
    
    
//    func getAllMessages(group: Group, handler: @escaping (_ messagesArray: [Messages]) -> ()) {
//        var groupMessageArray = [Messages]()
//        groupBase.child(group.groupId).child("messages").observe(.value) { (groupMessageSnapshot) in
//            guard let groupMessageSnapshot = groupMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
//            for groupMessage in groupMessageSnapshot {
//                let message = groupMessage.childSnapshot(forPath: "messageText").value as! String
//                let email = groupMessage.childSnapshot(forPath: "email").value as! String
//                let groupMessage = Messages(user: email, message : message)
//                groupMessageArray.append(groupMessage)
//            }
//            handler(groupMessageArray)
//        }
//    }
    
    func createGroup(withTitle title: String, emails: [String], handler: @escaping (_ groupCreated: Bool) -> ()) {
        groupBase.childByAutoId().updateChildValues(["title": title, "members": emails])
        handler(true)
    }
    
    
    
    func getAllGroups(handler: @escaping (_ groupsArray: [Group]) -> ()) {
        
        groupBase.observe(.value) { (groupSnapshot) in
            var groupsArray = [Group]()
            guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for group in groupSnapshot {
                let memberArray = group.childSnapshot(forPath: "members").value as! [String]
                if memberArray.contains((Auth.auth().currentUser?.email)!) {
                    let title = group.childSnapshot(forPath: "title").value as! String
                    let group = Group(title: title, id: group.key, members: memberArray, memberCount: memberArray.count)
                    groupsArray.append(group)
                }
            }
            handler(groupsArray)
        }
    }
    
}
    

