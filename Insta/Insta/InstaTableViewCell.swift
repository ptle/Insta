//
//  InstaTableViewCell.swift
//  Insta
//
//  Created by Peter Le on 3/19/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class InstaTableViewCell: UITableViewCell {
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var createdLabel: UILabel!
    

    var post: PFObject! {
        didSet {
            let postUser = post["author"] as! PFUser?
            self.nameLabel.text = postUser?.username
            self.captionLabel.text = post["caption"] as! String?
            let picture = post["media"] as! PFObject
            let imageData = picture["image"] as? PFFile
            imageData!.getDataInBackground { (imageInfo: Data?, error: Error?) in
                if(error == nil) {
                    let picture = UIImage(data: imageInfo!)
                    self.postImage.image = picture
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
