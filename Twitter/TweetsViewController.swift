//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Sunny Rochiramani on 5/24/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class TweetsViewController: UITableViewController, UINavigationBarDelegate {
    
    var tweets : [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 120
        
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 0.33, green: 0.67, blue: 0.93, alpha: 0)
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: "fetchTweets", forControlEvents: UIControlEvents.ValueChanged)
        
        fetchTweets()
    }

    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    @IBAction func onCompose(sender: AnyObject) {
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell", forIndexPath: indexPath) as! TweetTableViewCell
        let tweet = tweets![indexPath.row]
        cell.tweet = tweet
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let sender = sender as? TweetTableViewCell {
            let cell = sender as! TweetTableViewCell
            let indexPath = tableView.indexPathForCell(cell)!
            
            let tweet = self.tweets![indexPath.row]
            let tweetDetailViewController = segue.destinationViewController as! TweetDetailViewController
            tweetDetailViewController.tweet = tweet
        }

    }
    
    func fetchTweets() {
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
