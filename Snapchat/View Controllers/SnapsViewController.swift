//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Brent Scarbrough on 1/4/18.
//  Copyright © 2018 Brent Scarbrough. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var snaps : [Snap] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        let currentuser = Auth.auth().currentUser!.uid
        Database.database().reference().child("users").child(currentuser).child("snaps").observe(DataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
        
        
        let snap = Snap()
        
        //user.email = snapshot.value!["email"] as! String
        
        let snapshotValue = snapshot.value as? NSDictionary
        snap.imageURL = snapshotValue!["image"] as! String
        
        let snapshotValue2 = snapshot.value as? NSDictionary
        snap.from = snapshotValue2!["from"] as! String
        
        let snapshotValue3 = snapshot.value as? NSDictionary
        snap.descrip = snapshotValue3!["description"] as! String
            
            snap.key = snapshot.key
            
            let snapshotValue4 = snapshot.value as? NSDictionary
            snap.uuid = snapshotValue4!["uuid"] as! String
        
        //let snapshotValue4 = snapshot.value as? NSDictionary
        //    snap.descrip = snapshotValue4!["key"] as! String
        
        
        self.snaps.append(snap)
        
        self.tableView.reloadData()
    
    })
       
        
        Database.database().reference().child("users").child(currentuser).child("snaps").observe(DataEventType.childRemoved, with: {(snapshot) in
            print(snapshot)
            
            var index = 0
            
            for snap in self.snaps {
                if snap.key == snapshot.key {
                    self.snaps.remove(at: index)
                }
            index += 1
            }
            
            self.tableView.reloadData()
          
        
        })
    }
    
    
    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if snaps.count == 0 {
            return 1
        }else {
            return snaps.count}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = UITableViewCell()
        
        
        if snaps.count == 0 {
            cell.textLabel?.text = "You have no snaps 😥"
            
        } else {
        let snap = snaps[indexPath.row]
        cell.textLabel?.text = snap.from
        }
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "viewSnapSeque", sender: snap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewSnapSeque" {
        let nextVC = segue.destination as! ViewSnapViewController
        
        nextVC.snap = sender as! Snap
            
            
        }
    }
     
    
}
