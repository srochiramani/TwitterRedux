//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Sunny Rochiramani on 5/25/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet : Tweet? {
        didSet {
            let author = tweet?.author
            if author != nil {
                if author!.profileImageUrl != nil {
                    let authorAvataUrl = NSURL(string: author!.profileImageUrl!)
                    userAvatarImageView.setImageWithURL(authorAvataUrl)
                }
                userFullNameLabel.text = author!.name
                userHandleLabel.text = "@" + author!.screenName!
                tweetTextLabel.text = tweet?.text
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
