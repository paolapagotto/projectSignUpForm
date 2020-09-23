//
//  ViewController.swift
//  cadastro-user
//
//  Created by Paola Pagotto on 14/09/2020.
//  Copyright © 2020 Paola Pagotto. All rights reserved.
//

import UIKit

protocol AddUser {
    func getUserEmail()
}

class User: AddUser {
    var email:String
    var password:String
    init(email:String, password:String) {
        self.email = email
        self.password = password
    }
    
    func newUser(emailUser: String){
        setUserEmail(email: emailUser)
    }
    
    func setUserEmail(email: String){
        self.email = email
    }
    
    func getUserEmail(){
        print("User \(self.email)")
    }
}

class userData {
    private var userList = [AddUser]()
    
    func addUserToList(user: AddUser) {
        userList.append(user)
    }
    func printUserList() {
        for user in userList{
            print(user)
        }
    }
    private func userCard(user: AddUser){
        user.getUserEmail()
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var buttonSignUpUI: UIButton!
    
    @IBAction func buttonSignUp(_ sender: UIButton, forEvent event: UIEvent) {
        
        if validateInfo() {
            buttonSignUpUI.isEnabled = true
            buttonSignUpUI.backgroundColor = UIColor.green
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
        buttonSignUpUI.isEnabled = false
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z.]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "[A-Za-z0-9]{6,12}"

        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
    
    private func validateInfo() -> Bool {
        let user = User(email: textFieldEmail.text!,
                        password: textFieldPassword.text!)
        if !isValidEmail(textFieldEmail.text!)
        {
            print("Valid e-mail is required!")
            return false
        }
        if !isValidPassword(textFieldPassword.text!)
        {
            print("Password is required!")
            return false
        }
        print("User successfully signed up! ")
        buttonSignUpUI.isEnabled = true
        user.email = textFieldEmail.text ?? "email inválido"
        print(user.email)
        return true
    }
    
    private func cleanTextFields() {
        textFieldEmail.text = ""
        textFieldPassword.text = ""
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldEmail {
            textFieldPassword.becomeFirstResponder()
        } else {
            if validateInfo() {
                textField.resignFirstResponder()
            }
        }
        return true
    }
}



let user = User(email: "email@email.com", password:"123456")



