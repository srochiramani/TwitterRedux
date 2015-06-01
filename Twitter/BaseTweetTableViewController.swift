//
//  BaseTweetTableViewController.swift
//  Twitter
//
//  Created by Sunny Rochiramani on 5/31/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

@objc
protocol BaseTweetTableViewControllerDelegate {
    func openDrawer()
    func closeDrawer()
}

class BaseTweetTableViewController: UITableViewController, TweetTableViewCellDelegate {

    var delegate : BaseTweetTableViewControllerDelegate?
    
    var tweets : [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 120
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: "fetchData", forControlEvents: UIControlEvents.ValueChanged)
        
        fetchData()
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
        cell.delegate = self
        let tweet = tweets![indexPath.row]
        cell.tweet = tweet
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func onUserAvatarTapped(user : User) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("UserProfileViewController") as! UserProfileViewController
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        delegate?.closeDrawer()
        if let sender = sender as? TweetTableViewCell {
            let indexPath = tableView.indexPathForCell(sender)!
            let tweet = self.tweets![indexPath.row]
            let tweetDetailViewController = segue.destinationViewController as! TweetDetailViewController
            tweetDetailViewController.tweet = tweet
        }
        
    }
    
    func fetchData() {
    }

}
