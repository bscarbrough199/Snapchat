//
//  SelectUserViewController.swift
//  Snapchat
//
//  Created by Brent Scarbrough on 1/4/18.
//  Copyright © 2018 Brent Scarbrough. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class SelectUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var selectUsertable: UITableView!
    
    var users : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(users.count)
        
        // Do any additional setup after loading the view.
        self.selectUsertable.delegate = self
        self.selectUsertable.dataSource = self
        
            Database.database().reference().child("users").observe(DataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            
            let user = User()
            print(user)
            
            //user.email = snapshot.value!["email"] as! String
            let snapshotValue = snapshot.value as? NSDictionary
            user.email = snapshotValue!["email"] as! String
            
            print(user.email)
            
            //user.email = email
            user.uid = snapshot.key
            print(user.email)
                
            
            self.users.append(user)
            print(user.email)
            
            self.selectUsertable.reloadData()
            print(user.email)
                print (user.uid)
            print(self.users)
            
        })
        
        // Database.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email!)
        
    }
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell()
        let user = users[indexPath.row]

        cell.textLabel?.text = user.email
        print("The table has uploaded.")
        
        print(user.email)
            print(users)
        print(users.count)

        return cell
    }
    
    


}
