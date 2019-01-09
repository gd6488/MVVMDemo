//
//  User+CoreDataProperties.swift
//  MVVMDemo
//
//  Created by Daffolap on 08/01/19.
//  Copyright © 2019 Daffolap. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userName: String?
    @NSManaged public var password: String?

}
