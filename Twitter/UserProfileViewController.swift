//
//  UserProfileViewController.swift
//  Twitter
//
//  Created by Sunny Rochiramani on 5/31/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    var user : User!

    @IBOutlet weak var userBackgroundImageView: UIImageView!
    @IBOutlet weak var userAvatarImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    @IBOutlet weak var countsDivider: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.text = user.name!
        userHandleLabel.text = "@" + user.screenName!
        
        tweetCountLabel.text = String(user.tweetCount!)
        followersCountLabel.text = String(user.followersCount!)
        followingCountLabel.text = String(user.followingCount!)
        
        if let backgroundUrl = user.profileBannerUrl {
            let backgroundNSUrl = NSURL(string: backgroundUrl)
            userBackgroundImageView.setImageWithURL(backgroundNSUrl)
            userBackgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
            userBackgroundImageView.clipsToBounds = true
        }

        let userAvatarImageUrl = NSURL(string: user.profileImageUrl!)
        userAvatarImageView.setImageWithURL(userAvatarImageUrl)
        userAvatarImageView.layer.borderWidth = 2.0
        userAvatarImageView.layer.borderColor = UIColor.whiteColor().CGColor
        
    }
    
    override func viewDidAppear(animated: Bool) {
        // attach the user tweets table view controller
        let vc = storyboard?.instantiateViewControllerWithIdentifier("UserProfileTableViewController") as! UITableViewController
        vc.view.frame.offset(dx: 0, dy: countsDivider.frame.maxY)
        view.addSubview(vc.view)
        addChildViewController(vc)
        vc.didMoveToParentViewController(self)
    }
    
    
}
