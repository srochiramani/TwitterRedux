//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Sunny Rochiramani on 5/25/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    var tweet : Tweet?

    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var userTweetMsgLabel: UILabel!
    @IBOutlet weak var userTimestampLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIImageView!
    @IBOutlet weak var retweetButton: UIImageView!
    @IBOutlet weak var favoriteButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = tweet {
            if let author = tweet.author {
                userAvatarImageView.setImageWithURL(NSURL(string: author.profileImageUrl!))
                userNameLabel.text = author.name!
                userHandleLabel.text = "@" + author.screenName!
            }
            userTweetMsgLabel.text = tweet.text!
            userTimestampLabel.text = tweet.createdAtString
        }
        
        let replyTapGesture = UITapGestureRecognizer(target: self, action: "replyTapped:")
        replyButton.addGestureRecognizer(replyTapGesture)
        replyButton.userInteractionEnabled = true
        
        let reTweetTapGesture = UITapGestureRecognizer(target: self, action: "reTweetTapped:")
        retweetButton.addGestureRecognizer(reTweetTapGesture)
        retweetButton.userInteractionEnabled = true
        
        let favoriteTapGesture = UITapGestureRecognizer(target: self, action: "favoriteTapped:")
        favoriteButton.addGestureRecognizer(favoriteTapGesture)
        favoriteButton.userInteractionEnabled = true
        
    }

    @IBAction func onHomeTapped(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onReplyClicked(sender: AnyObject) {
        let vc = ComposeTweetViewController()
        vc.tweetReplyId = tweet?.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func replyTapped(gesture: UIGestureRecognizer) {
        onReplyClicked(self)
    }
    
    func reTweetTapped(gesture: UIGestureRecognizer) {
        TwitterClient.sharedInstance.reTweet(tweet!.id!)
    }
    
    func favoriteTapped(gesture : UIGestureRecognizer) {
        TwitterClient.sharedInstance.favoriteTweet(tweet!.id!)
    }
    
}
