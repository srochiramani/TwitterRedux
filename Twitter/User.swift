//
//  User.swift
//  Twitter
//
//  Created by Sunny Rochiramani on 5/21/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

var _currentUser : User?
let currentUserKey = "kCurrentUserKey"

let userLoginNotification = "userLoginNotification"
let userLogoutNotification = "userLogoutNotification"

class User: NSObject {
    
    var name : String?
    var screenName : String?
    var profileImageUrl : String?
    var profileBannerUrl : String?
    var tweetCount : Int?
    var followingCount : Int?
    var followersCount : Int?
    var desc : String?
    var location : String?
    
    var dictionary : NSDictionary
    
    init(dictionary : NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        profileBannerUrl = dictionary["profile_banner_url"] as? String
        tweetCount = dictionary["statuses_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        followersCount = dictionary["followers_count"] as? Int
        desc = dictionary["description"] as? String
        location = dictionary["location"] as? String
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userLogoutNotification, object: nil)
    }
    
    class var currentUser : User? {
        
        get {
            if (_currentUser == nil) {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    var dict = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSDictionary
                    _currentUser = User(dictionary: dict)
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            if _currentUser != nil {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
    }
   
}
