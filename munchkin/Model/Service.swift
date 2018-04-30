//
//  Service.swift
//  munchkin
//
//  Created by Guilherme Siepmann on 30/04/2018.
//  Copyright © 2018 Guilherme Siepmann. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Service {
    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate
    fileprivate lazy var context = appDelegate.persistentContainer.viewContext
    
    static let shared = Service()
    
    func addUser(_ user: UserModel) {
        createUser(user)
        saveContext()
    }
    
    @discardableResult
    fileprivate func createUser(_ user: UserModel) -> User {
        let newUser = User(context: context)
        newUser.name = user.name
        newUser.gender = user.gender.rawValue
        
        return newUser
    }
    
    func addGroup(_ groupName: String, users: [UserModel]) {
        let newGroup = Group(context: context)
        newGroup.name = groupName
        
        users.forEach { user in
            newGroup.user = createUser(user)
        }
        saveContext()
    }
    
    fileprivate func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed saving user")
        }
    }
}

//MARK: - List
extension Service {
    func listUsers() -> [UserModel] {
        var users: [User] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            users = try context.fetch(fetchRequest) as! [User]
        } catch {
            print("Fetching Failed")
        }
        
        return users.map {
            UserModel($0.name!, gender: Gender(rawValue: $0.gender ?? "0")!, objectId: $0.objectID)
        }
    }
    
    func listGroupData(groupName name: String) -> [Group] {
        var groupData: [Group] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Group")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            groupData = try context.fetch(fetchRequest) as! [Group]
        } catch {
            print("Fetching Failed")
        }
        return groupData
    }
}

//MARK: - Delete
extension Service{
    func deleteUser(_ user: UserModel) {
        guard let objId = user.objectId else { return }
        context.delete(context.object(with: objId))
        saveContext()
    }
}
