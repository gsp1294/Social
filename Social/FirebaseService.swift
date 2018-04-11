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
    
}
