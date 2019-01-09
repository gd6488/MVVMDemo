//
//  Box.swift
//  MVVMDemo
//
//  Created by Daffolap on 08/01/19.
//  Copyright © 2019 Daffolap. All rights reserved.
//

import Foundation
import UIKit
import CoreData
var moc:NSManagedObjectContext? {
    return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
}
final class Box<T> {
    typealias Listener = (T)->()
    var listener:Listener?
    var value:T {
        didSet {
            self.listener?(value)
        }
    }
    init(_ value:T) {
        self.value = value
    }
    func bind(_ listener: @escaping Listener){
        self.listener = listener
        self.listener?(value)
    }
}

protocol AlertMessage {
    
}
extension AlertMessage where Self:UIViewController {
    func show(title:String?,message:String?,okTitle:String?,cancelTitle:String?,ok: ((UIAlertAction)->())?,cancel: ((UIAlertAction)->())?){
     let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction.init(title: okTitle, style: .default, handler: ok))
       alert.addAction(UIAlertAction.init(title: cancelTitle, style: .cancel, handler: cancel))
    present(alert, animated: true, completion: nil)
        
    }
}
