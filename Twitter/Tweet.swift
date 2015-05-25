//
//  Tweet.swift
//  Twitter
//
//  Created by Sunny Rochiramani on 5/21/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var author : User?
    var text : String?
    var createdAtString : String
    var createdAt : NSDate?
    
    var dictionary : NSDictionary
    
    init (dictionary : NSDictionary) {
        self.dictionary = dictionary
        
        author = User(dictionary: (dictionary["user"] as! NSDictionary))
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as! String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString)
    }
    
    class func tweetsWithArray(array : [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dict in array {
            let tweet = Tweet(dictionary: dict)
            tweets.append(tweet)
        }
        
        return tweets
    }
   
}
