//
//  MentionsTableViewController.swift
//  Twitter
//
//  Created by Sunny Rochiramani on 5/31/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class MentionsTableViewController: BaseTweetTableViewController, TweetTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
