//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Brent Scarbrough on 1/4/18.
//  Copyright © 2018 Brent Scarbrough. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
