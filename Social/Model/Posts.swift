//
//  Posts.swift
//  Social
//
//  Created by Gayatri Patil on 12/04/18.
//  Copyright © 2018 Gayatri Patil. All rights reserved.
//

import Foundation

class Posts{
    var user : String?
    var post : String?
    }

class Messages {
    var user : String?
    var message : String?
    
    init(user : String, message : String) {
        self.user = user
        self.message = message
    }
}
