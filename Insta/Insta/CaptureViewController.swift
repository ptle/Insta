//
//  CaptureViewController.swift
//  Insta
//
//  Created by Peter Le on 3/19/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var captureButton: UIButton!
    
    @IBOutlet weak var postButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        postButton.layer.cornerRadius = 5
        
        selectButton.backgroundColor = .clear
        selectButton.layer.cornerRadius = 5
        selectButton.layer.borderWidth = 1
        selectButton.layer.borderColor = UIColor.black.cgColor

        captureButton.backgroundColor = .clear
        captureButton.layer.cornerRadius = 5
        captureButton.layer.borderWidth = 1
        captureButton.layer.borderColor = UIColor.black.cgColor

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    @IBAction func capture(_ sender: Any) {
        let cameraSource = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        // Limit to PhotoLibrary if no camera available
        let sourceType = cameraSource ? UIImagePickerControllerSourceType.camera : UIImagePickerControllerSourceType.photoLibrary
        
        let viewController = UIImagePickerController()
        viewController.delegate = self
        viewController.sourceType = sourceType
        
        self.present(viewController, animated: true, completion: nil)
    }

    
    @IBAction func selectImage(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        pictureView.image = originalImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func post(_ sender: Any) {
        if (captionField.text! == "" || pictureView.image  == nil)
        {
            let alertController = UIAlertController(title: "Error", message: "Make sure to have a photo and caption", preferredStyle: .alert)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }
        else
        {
            let scaledImage = self.resize(image: self.pictureView.image!, newSize: CGSize(width: 750, height: 750))
            let imageData = UIImageJPEGRepresentation(scaledImage, 0)
            let imageFile = PFFile(name:"image.jpg", data:imageData!)
            let picture = PFObject(className: "Picture")
            picture["image"] = imageFile
            
            
            let post = PFObject(className: "Post")
            post["media"] = picture
            post["author"] = PFUser.current() // Pointer column type that points to PFUser
            post["caption"] = captionField.text!
            post["likesCount"] = 0
            post["commentsCount"] = 0
        
            MBProgressHUD.showAdded(to: self.view, animated: true)
            post.saveInBackground { (success: Bool, error: Error?) in
                if (success) {
                    print("Success! You created a post! 👍")
                    self.tabBarController!.selectedIndex = 0
                    self.view.endEditing(true)
                    MBProgressHUD.hide(for: self.view, animated: true)
                } else {
                    MBProgressHUD.hide(for: self.view, animated: true)
                
                    print(error?.localizedDescription ?? "unknown error occured! 😬")
                
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription ?? "unknown error occured! 😬", preferredStyle: .alert)
                
                    // create an OK action
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        // handle response here.
                    }
                    // add the OK action to the alert controller
                    alertController.addAction(OKAction)
                
                    self.present(alertController, animated: true) {
                        // optional code for what happens after the alert controller has finished presenting
                    }
                }
            }
        
            captionField.text = ""
            pictureView.image = nil
        }
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    @IBAction func onTap(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
