//
//  UserProfileTableViewController.swift
//  Twitter
//
//  Created by Sunny Rochiramani on 5/31/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class UserProfileTableViewController: BaseTweetTableViewController {
    
    var user : User!
    
    override func fetchData() {
        TwitterClient.sharedInstance.userTweets(user.screenName!, requestCompletion: { (tweets, error) -> () in
            self.tweets = tweets
            if tweets != nil {
                self.tweets = tweets
                self.tableView.reloadData()
            } else {
                // handle error
            }
            self.refreshControl?.endRefreshing()
        })
    }

}
