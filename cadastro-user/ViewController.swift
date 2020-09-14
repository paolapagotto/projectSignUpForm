//
//  ViewController.swift
//  cadastro-user
//
//  Created by Paola Pagotto on 14/09/2020.
//  Copyright © 2020 Paola Pagotto. All rights reserved.
//

import UIKit


protocol AddUser {
    func getUser()
}

class User: AddUser {
    var userId: Int
    var email:String
    var password:String
    init(userId:Int, email:String, password:String) {
        self.userId = userId
        self.email = email
        self.password = password
    }
    
    func getUser(){
        if self.email == email{
            print("This user already exists")
        } else {
            userId += 1
            print("New User: \(email)")
        }
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
        user.getUser()
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var buttonSignUpUI: UIButton!
    
    @IBAction func buttonSignUp(_ sender: UIButton, forEvent event: UIEvent) {
        if validateInfo() {
            buttonSignUpUI.isEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
        buttonSignUpUI.isEnabled = false
    }
    
    private func validateInfo() -> Bool {
        if textFieldEmail.text == nil || textFieldEmail.text!.isEmpty {
            print("Email is required!")
            return false
        }
        if textFieldPassword.text == nil || textFieldPassword.text!.isEmpty {
            print("Password is required!")
            return false
        }
        print("User signed up successfully")
        buttonSignUpUI.isEnabled = true
        return true
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


