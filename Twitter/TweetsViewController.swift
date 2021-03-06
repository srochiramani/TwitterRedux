//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Sunny Rochiramani on 5/24/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class TweetsViewController: BaseTweetTableViewController, UINavigationBarDelegate, TweetTableViewCellDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    @IBAction func onCompose(sender: AnyObject) {
    }
    
    override func fetchData() {
        TwitterClient.sharedInstance.userHomeTimeline { (tweets, error) -> () in
            self.tweets = tweets
            if tweets != nil {
                self.tweets = tweets
                self.tableView.reloadData()
            } else {
                // handle error
            }
            self.refreshControl?.endRefreshing()
        }
    }


}
