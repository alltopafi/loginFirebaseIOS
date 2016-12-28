//
//  ViewController.swift
//  loginTestApp
//
//  Created by Jesse Alltop on 12/27/16.
//  Copyright © 2016 Jesse Alltop. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var ref: FIRDatabaseReference!
    //let ref = FIRDatabase.database().reference(withPath: "users")

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        self.title = "Logout"
        ref = FIRDatabase.database().reference(withPath: "users")
//        createTextField(title: "Username")
        usernameField = createTextField(title: "Username", xCord: 20, yCord: 250, widthSize: 300, heightSize: 40, color: UIColor.white)
        usernameField.delegate = self
        
        passwordField = createTextField(title: "Password", xCord: 20, yCord: 300, widthSize: 300, heightSize: 40, color: UIColor.white)
        passwordField.delegate = self
        
        let submitButton = createButton(title: "Login", xCord: 20, yCord: 350, widthSize: 75, heightSize: 40, color: UIColor.blue)
        submitButton.addTarget(self, action: #selector(self.loginButtonTapped), for: .touchUpInside)
        
        let newAccountButton = createButton(title: "Create Account", xCord: 170, yCord: 350, widthSize: 150, heightSize: 40, color: UIColor.blue)
        newAccountButton.addTarget(self, action: #selector(self.newAccountButtonTapped), for: .touchUpInside)
        
        self.view.addSubview(usernameField)
        self.view.addSubview(passwordField)
        self.view.addSubview(submitButton)
        self.view.addSubview(newAccountButton)
        
    }

    
    
    func createTextField(title: String, xCord: Int , yCord: Int , widthSize: Int, heightSize: Int, color: UIColor) -> UITextField {
        let tempField = UITextField(frame: CGRect(x: xCord, y: yCord, width: widthSize, height: heightSize))
        tempField.placeholder = title
        tempField.font = UIFont.systemFont(ofSize: 15)
        tempField.borderStyle = UITextBorderStyle.roundedRect
        tempField.autocorrectionType = UITextAutocorrectionType.no
        tempField.keyboardType = UIKeyboardType.default
        tempField.returnKeyType = UIReturnKeyType.done
        tempField.clearButtonMode = UITextFieldViewMode.whileEditing;
        tempField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        tempField.backgroundColor = color
        
        return tempField
    }
    
    func createButton(title: String, xCord: Int , yCord: Int , widthSize: Int, heightSize: Int, color: UIColor) -> UIButton {
        let tempButton = UIButton(frame: CGRect(x: xCord, y: yCord, width: widthSize, height: heightSize))
        tempButton.setTitle(title, for: .normal)
        tempButton.backgroundColor = color
        
        return tempButton
    }

    func loginButtonTapped(){
        print("login tapped")
        
        guard let email = self.usernameField.text, let password = self.passwordField.text
            else{
                print("Form is not valid")
                return
            }
        if email == "" || password == "" {
            print("Form cannot be empty")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
        
        if error != nil {
            print(error)
            return
        }else{
            let logView = LoggedInViewController()
            self.navigationController?.pushViewController(logView, animated: true)
        }
    }
    }

    func newAccountButtonTapped(){
        guard let email = self.usernameField.text, let password = self.passwordField.text
            else{
                print("Form is not valid")
                return
            }
        
        if email == "" || password == "" {
            print("Form cannot be empty")
            return
            }
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error)
                return
            }else{
                let logView = LoggedInViewController()
                self.navigationController?.pushViewController(logView, animated: true)
            }
        }
    }
}


