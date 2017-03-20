//
//  ProfileViewController.swift
//  Insta
//
//  Created by Peter Le on 3/19/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class ProfileViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var currentaccountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        logoutButton.layer.cornerRadius = 5
        currentaccountLabel.text = PFUser.current()?.username
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logout(_ sender: Any) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        PFUser.logOut()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Logout"), object: nil)
        MBProgressHUD.hide(for: self.view, animated: true)
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
