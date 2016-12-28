//
//  LoggedInViewController.swift
//  loginTestApp
//
//  Created by Jesse Alltop on 12/28/16.
//  Copyright © 2016 Jesse Alltop. All rights reserved.
//

import UIKit
import Firebase

class LoggedInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        self.title = "Logged in"
        self.navigationController?.isNavigationBarHidden = false


        
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)
        if parent == nil {
            logoutBack()
        }
    }
    
    func logoutBack(){
        print("logout called")
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
    
}
