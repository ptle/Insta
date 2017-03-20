//
//  LoginViewController.swift
//  Insta
//
//  Created by Peter Le on 3/10/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD


class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        usernameField.becomeFirstResponder()
        
        signinButton.layer.cornerRadius = 5
        
        signupButton.backgroundColor = .clear
        signupButton.layer.cornerRadius = 5
        signupButton.layer.borderWidth = 1
        signupButton.layer.borderColor = UIColor.black.cgColor

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let usernametext = usernameField.text!
        let passwordtext = passwordField.text!
        if usernametext == "" || passwordtext == ""
        {
            let alertController = UIAlertController(title: "Error", message: "Make sure email and password are filled out", preferredStyle: .alert)
            
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
            MBProgressHUD.showAdded(to: self.view, animated: true)
            PFUser.logInWithUsername(inBackground: usernametext, password: passwordtext) { (user: PFUser?, error: Error?) in
                if user != nil {
                    print("Success! You are now logged in! 👍")
                    self.performSegue(withIdentifier: "loginsegue", sender: nil)
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
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let usernametext = usernameField.text!
        let passwordtext = passwordField.text!
        if usernametext == "" || passwordtext == ""
        {
            let alertController = UIAlertController(title: "Error", message: "Make sure email and password are filled out", preferredStyle: .alert)
            
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
            let newUser = PFUser()
            
            newUser.username = usernameField.text
            newUser.password = passwordField.text
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if (success) {
                    print("Success! You created a user! 👍")
                    self.performSegue(withIdentifier: "loginsegue", sender: nil)
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
        }
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
