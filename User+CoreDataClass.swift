//
//  User+CoreDataClass.swift
//  MVVMDemo
//
//  Created by Daffolap on 08/01/19.
//  Copyright © 2019 Daffolap. All rights reserved.
//
//

import Foundation
import CoreData

struct  UserModel {
    var userName: String = ""
    var password: String = ""
    init(userName: String = "",password: String = "") {
    self.userName = userName
    self.password = password
    }
     init(user:User) {
     self.init(userName: user.userName ?? "", password: user.password ?? "")
    }
}
public class User: NSManagedObject {
    class func findOrCreateUser(matching user:UserModel,in context:NSManagedObjectContext) throws ->User {
        let request:NSFetchRequest = User.fetchRequest()
        if let result = try? context.fetch(request) {
            for object in result {
                context.delete(object)
            }
        }
        
        request.predicate = NSPredicate(format: "userName = %@", user.userName)
        do {
            let matches = try context.fetch(request)
            
            if matches.count > 0 {
                // assert 'sanity': if condition false ... then print message and interrupt program
                assert(matches.count == 1, "User.findOrCreateUser -- database inconsistency")
                return matches[0]
            }
        } catch {
            throw error
        }
        // no match
        let newuser = User(context: context)
        newuser.userName = user.userName
        newuser.password = user.password
        return newuser
    }
    class func getUser(in context:NSManagedObjectContext) throws ->User? {
        let request:NSFetchRequest = User.fetchRequest()
        var matches = [User]()
        do {
             matches = try context.fetch(request)
            if matches.count > 0 {
                // assert 'sanity': if condition false ... then print message and interrupt program
                
                return matches[0]
            }
        } catch {
            throw error
        }
        return nil
    }
}
