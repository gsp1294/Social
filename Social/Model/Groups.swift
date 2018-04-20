

import Foundation

class Group {
     var groupTitle: String
     var groupId: String
     var memberCount: Int
     var members: [String]
    
    
    init(title: String, id: String, members: [String], memberCount: Int) {
        self.groupTitle = title
        self.groupId = id
        self.members = members
        self.memberCount = memberCount
    }
}










