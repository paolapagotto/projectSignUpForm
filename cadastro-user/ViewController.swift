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
    
    let validityType: String.ValidityType = .email
    
//    lazy var textField: UITextField = {
//        let tf = textFieldEmail
//        tf!.placeholder = "\(validityType)"
//        return tf!
//    }()
//
//    lazy var label: UILabel = {
//        let label = UILabel()
//        return label
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
        buttonSignUpUI.isEnabled = false
    }
    
//    func setupViews() {
//        navigationItem.title = " "
//        view.backgroundColor = .white
//
//        view.addSubview(textField)
//        view.addSubview(label)
//    }
    
    func handleTextChange() {
        guard let text = textFieldEmail.text else {return}
            print(text)
            switch validityType{
            case .email:
                if text.isValid(validityType){
                    print("Valid \(validityType)")
                } else {
                    print("Not a valid \(validityType)")
                }
            }
    }

    
    
    private func validateInfo() -> Bool {
        let user = User(email: textFieldEmail.text!,
                        password: textFieldPassword.text!)
        
        if textFieldEmail.text == nil ||
            textFieldEmail.text!.isEmpty
        {
            print("Valid e-mail is required!")
            return false
        }
        if textFieldPassword.text == nil ||
            textFieldPassword.text!.isEmpty
        {
            print("Password is required!")
            return false
        }
        if (textFieldPassword.text?.count)! > 6 ||
            (textFieldPassword.text?.count)! < 6
        {
            print("The password must have 6 chars")
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

extension String {
    
    enum ValidityType {
        case email
    }
    enum Regex: String {
        case email = "[A-Z0-9a-z._-+%]+@[A-Z0-9a-z._-]+\\.[A-Za-z]{2,64}"
    }
    func isValid(_ validityType: ValidityType) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validityType {
            case .email:
                regex = Regex.email.rawValue
       }
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}



// let user = User(email: "email@email.com", password:"123456")


