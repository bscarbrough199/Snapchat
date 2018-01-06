//
//  ViewSnapViewController.swift
//  Snapchat
//
//  Created by Brent Scarbrough on 1/5/18.
//  Copyright © 2018 Brent Scarbrough. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseStorage


class ViewSnapViewController: UIViewController {


    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var snapPic: UIImageView!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        label.text = snap.descrip
        
        snapPic.sd_setImage(with: URL(string: snap.imageURL))
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("Picture will be deleted.")
        
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").child(snap.key).removeValue()
        
        Storage.storage().reference().child("Images").child("\(snap.uuid).jpg").delete { (error) in
            print ("We deleted the pic.")
        }
        
    }
    
    


}
