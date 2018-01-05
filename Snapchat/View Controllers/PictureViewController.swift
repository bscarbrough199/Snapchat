//
//  PictureViewController.swift
//  Snapchat
//
//  Created by Brent Scarbrough on 1/4/18.
//  Copyright © 2018 Brent Scarbrough. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage


class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicker = UIImagePickerController()
    
    
    

    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        



        // Do any additional setup after loading the view.
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        
        imagePicker.dismiss(animated: true, completion: nil)
    }

    @IBAction func cameraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
        

    }
    
    
    
    
    @IBAction func nextTapped(_ sender: Any) {

        nextButton.isEnabled = false
        
        let imagesFolder = Storage.storage().reference().child("Images")
        // let imageData = UIImagePNGRepresentation(imageView.image!)
        // let imageData = UIImagePNGRepresentation(self.imageView.image!)
        let imageData = UIImageJPEGRepresentation(self.imageView.image!, 0.1)
        
        
        imagesFolder.child("\(NSUUID().uuidString).jpg").putData(imageData!, metadata: nil) { (metadata, error) in
            print ("Trying to Upload...")
            if error != nil {
                print("We had an error: \(error)")
            }
            else {
                
                print(metadata?.downloadURL())
                
                self.performSegue(withIdentifier: "selectUserSegue", sender: nil)
            }
        }
        
        
        
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //imagesFolder.child("images.png").putData?(uploadData: imageData, metadata: nil, completion: {(metadata, error) in
            
         //)
        //}
    }
    
}
