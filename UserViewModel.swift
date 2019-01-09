//
//  UserViewModel.swift
//  MVVMDemo
//
//  Created by Daffolap on 08/01/19.
//  Copyright © 2019 Daffolap. All rights reserved.
//

import Foundation
import CoreData
import UIKit
enum ValidationState {
case Valid
case Invalid(String)
}

final class UserViewModel {

private let minimumUsernamelength = 10
private let minimumPasswordlength = 8
    private var user = UserModel(){
        didSet {
            userName = Box(user.userName)
            password = Box(user.password)
        }
    }
var userName:Box<String?> = Box(nil)
var password:Box<String?> = Box(nil)
    
    init(_ user:UserModel = UserModel()) {
        if  let user = try! User.getUser(in: moc!) {
            self.userName = Box(user.userName)
            self.password = Box(user.password)
            //self.user = UserModel.init(userName: , password: user.password ?? "")
        }else{
     self.user = user
        }
    }
}


// input UI update Model
extension UserViewModel {
    func updateUsername(username:String){
      self.user.userName = username
    }
    func updatePassword(password:String){
        self.user.password = password
    }
}

extension UserViewModel {
    func validate()->ValidationState{
        guard let username = userName.value,let password = password.value else {
        return .Invalid("username or password is empty!")
        }
        if username.count < minimumUsernamelength {
           return .Invalid("username must be of \(minimumUsernamelength) characters")
        }
        if password.count < minimumPasswordlength {
            return .Invalid("password must be of \(minimumPasswordlength) characters")
        }
        return .Valid
    }
}

extension UserViewModel {
    func login(_ complition:(UserModel)->()){
        do{
            userName = Box(user.userName)
            password = Box(user.password)
         _ = try User.findOrCreateUser(matching: self.user, in: moc!)
          try moc?.save()
        }catch let error {
          print(error)
        }
     complition(self.user)
    }
}
