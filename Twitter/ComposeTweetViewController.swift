//
//  ComposeTweetViewController.swift
//  Twitter
//
//  Created by Sunny Rochiramani on 5/25/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController, UITextViewDelegate {

    var tweetReplyId : String?

    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var userTweetText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 0.33, green: 0.67, blue: 0.93, alpha: 0)
        
        let currentUser = User.currentUser
        if let user = currentUser {
            if let avatarUrl = user.profileImageUrl {
                userAvatarImageView.setImageWithURL(NSURL(string: avatarUrl))
            }

            userNameLabel.text = user.name
            userHandleLabel.text = "@" + user.screenName!
        }
        
        userTweetText.delegate = self
        userTweetText.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTweet(sender: AnyObject) {
        // TODO: Validation of tweet length
        TwitterClient.sharedInstance.postTweet(userTweetText.text, replyToId: tweetReplyId)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textViewDidChange(textView: UITextView) {
        let tweetText = textView.text as String
        println("length: \(count(tweetText))")
    }

}
