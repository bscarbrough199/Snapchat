//
//  SignInViewController.swift
//  Snapchat
//
//  Created by Brent Scarbrough on 1/2/18.
//  Copyright © 2018 Brent Scarbrough. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    @IBAction func loginTapped(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("We are signing in!")
            if error != nil {
                print("Uh Oh... There was an error logging in: \(error)")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We tried to create a user.")
                    
                    if error != nil {
                        print("Uh Oh... There was an error logging in: \(error)")
                    }
                    else {
                        print("Created user successfully.")
                        
                        //var ref : DatabaseReference!
                        //ref = Database.database().reference()
                    Database.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email!)
                        
                        self.performSegue(withIdentifier: "signInSegue", sender: nil)
                    }
                })
            }
                else {
                    print("Sweet! Let's play!")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
            
        })
        
 }

    }


