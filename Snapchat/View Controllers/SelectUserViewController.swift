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
    var imageURL : String = ""
    var descrip : String = ""
    var uuid : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(users.count)
        
        // Do any additional setup after loading the view.
        self.selectUsertable.delegate = self
        self.selectUsertable.dataSource = self
        
            Database.database().reference().child("users").observe(DataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            
            let user = User()
            
            //user.email = snapshot.value!["email"] as! String
            let snapshotValue = snapshot.value as? NSDictionary
            user.email = snapshotValue!["email"] as! String
            
            
            //user.email = email
            user.uid = snapshot.key
                
            
            self.users.append(user)
            
            self.selectUsertable.reloadData()
            
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = users[indexPath.row]
        let snap = ["from":user.email, "description":descrip, "image":imageURL, "uuid":uuid]
        
        Database.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
        
        navigationController!.popToRootViewController(animated: true)
    }
    
    
    


}
