//
//  ViewController.swift
//  MVVMDemo
//
//  Created by Daffolap on 08/01/19.
//  Copyright © 2019 Daffolap. All rights reserved.
//

import UIKit

class LoginVC: UIViewController,AlertMessage {
    @IBOutlet weak var txtfUsername: UITextField!
    @IBOutlet weak var txtfPassword: UITextField!
    
    var userViewModel = UserViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
            
       
        txtfUsername.delegate = self
        txtfPassword.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
        userViewModel.userName.bind { [unowned self] in
         self.txtfUsername.text = $0
        }
        userViewModel.password.bind { [unowned self] in
            self.txtfPassword.text = $0
        }
    }

    @IBAction func loginTapped(_ sender: Any) {
       
        switch userViewModel.validate() {
        case ValidationState.Valid:
            userViewModel.login { user in
               
            }
        case ValidationState.Invalid(let error):
            show(title: nil, message: error, okTitle:"Ok", cancelTitle: "Cancel", ok: nil) { act in
                
            }
        }
    }
    

}


extension LoginVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtfUsername {
           txtfUsername.text = userViewModel.userName.value
        }
     
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtfUsername {
            txtfUsername.text = userViewModel.userName.value
        }else if textField == txtfPassword {
           txtfPassword.text = userViewModel.password.value
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        print(newString)
        if textField == txtfUsername {
         userViewModel.updateUsername(username: newString)
        }else if textField == txtfPassword {
          userViewModel.updatePassword(password: newString)
        }
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        if textField == txtfUsername {
        txtfPassword.becomeFirstResponder()
        }else{

            textField.resignFirstResponder()
        }
        
        return true
    }
}
