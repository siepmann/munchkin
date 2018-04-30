//
//  UserModel.swift
//  munchkin
//
//  Created by Guilherme Siepmann on 30/04/2018.
//  Copyright © 2018 Guilherme Siepmann. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum Gender: String {
    case male = "0"
    case female = "1"
}

class UserModel {
    var objectId: NSManagedObjectID? = nil
    var name: String = ""
    var gender: Gender = .male
    
    init() { }
    
    init(_ name: String, gender: Gender = .male, objectId: NSManagedObjectID? = nil) {
        self.name = name
        self.gender = gender
        if let objId = objectId {
            self.objectId = objId
        }
    }
}

class GroupModel {
    var groupName: String
    var users: [UserModel]
    
    init(_ name: String, users: [UserModel]) {
        self.groupName = name
        self.users = users
    }
}
