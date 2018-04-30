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
    
    func addUser(_ user: User) {
        createUser(user)
        saveContext()
    }
    
    @discardableResult
    fileprivate func createUser(_ user: User) -> User {
        let newUser = User(context: context)
        newUser.name = user.name
        newUser.gender = user.gender
        
        return newUser
    }
    
    func addGroup(_ groupName: String, users: [User]) {
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
    func listUsers() -> [User] {
        var users: [User] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            users = try context.fetch(fetchRequest) as! [User]
        } catch {
            print("Fetching Failed")
        }
        
        return users
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
