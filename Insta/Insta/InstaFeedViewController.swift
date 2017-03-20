//
//  InstaFeedViewController.swift
//  Insta
//
//  Created by Peter Le on 3/19/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit
import Parse

class InstaFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var data: [PFObject]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImage(named: "insta-logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: "onTimer", userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onTimer() {
        // Add code to be run periodically
        var query = PFQuery(className:"Post")
        
        // Retrieve the most recent ones
        query.order(byDescending: "createdAt")
        
        // Include the post data with each comment
        query.includeKey("media")
        query.includeKey("author")
        query.includeKey("caption")
        query.includeKey("createdAt")
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if error == nil {
                // The find succeeded.
                //print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    self.data = objects
                }
            } else {
                // Log details of the failure
                print("Error: \(error!)")
            }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data != nil {
            return data.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstaTableViewCell", for: indexPath as IndexPath) as! InstaTableViewCell
        
        cell.post = data[indexPath.row]
        
        return cell
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
