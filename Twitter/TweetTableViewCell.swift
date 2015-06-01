//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Sunny Rochiramani on 5/25/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

protocol TweetTableViewCellDelegate {
    func onUserAvatarTapped(user : User)
}

class TweetTableViewCell: UITableViewCell {
    
    var delegate : TweetTableViewCellDelegate?
    
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet : Tweet? {
        didSet {
            let author = tweet?.author
            if let author = author {
                if author.profileImageUrl != nil {
                    let authorAvataUrl = NSURL(string: author.profileImageUrl!)
                    userAvatarImageView.setImageWithURL(authorAvataUrl)
                    userAvatarImageView.userInteractionEnabled = true
                    userAvatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("onUserAvatarTapped")))
                }
                userFullNameLabel.text = author.name
                userHandleLabel.text = "@" + author.screenName!
                tweetTextLabel.text = tweet?.text
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userAvatarImageView.layer.cornerRadius = 2
        userAvatarImageView.clipsToBounds = true
        layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tweetTextLabel.preferredMaxLayoutWidth = CGRectGetWidth(tweetTextLabel.frame)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func onUserAvatarTapped() {
        print("onUserAvatarTapped")
        if let delegate = delegate {
            delegate.onUserAvatarTapped(tweet!.author!)
        }
    }

}
