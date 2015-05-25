//
//  TwitterClient.swift
//  Twitter
//
//  Created by Sunny Rochiramani on 5/20/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

let twitterConsumerKey = "2zzg41LFugMboK3RjQ4PeyDuN"
let twitterConsumerSecret = "v8mLYKyXPVee02WM3LIqXt3TOpeIjh0d5cnGhVTw68Qonga4pN"
let twitterBaseUrl = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion : ((user : User?, error : NSError?) -> ())?
    
    class var sharedInstance : TwitterClient {
        
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseUrl, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func loginWithCompletion(loginCompletion: (user : User?, error : NSError?) -> ()) {
        self.loginCompletion = loginCompletion
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        // Fetch request token and redirect to authorization page
        let requestUrl = "oauth/request_token"
        let callbackUrl = NSURL(string: "cptwitter://oauth")
        TwitterClient.sharedInstance.fetchRequestTokenWithPath(requestUrl, method: "GET", callbackURL: callbackUrl, scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            println("Got the request token")
            let authUrl = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authUrl!)
            }, failure: { (error: NSError!) -> Void in
                self.loginCompletion?(user : nil, error : error)
                println("Failed to get oAuth token")
        })
        
    }
    
    func openURL(url : NSURL) {
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (access_token: BDBOAuth1Credential!) -> Void in
            println("Got access token")
            
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(access_token)
            println("Saving access token")
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response : AnyObject!) -> Void in
                var user = User(dictionary: (response as! NSDictionary))
                println("User \(user.name)")
                User.currentUser = user
                self.loginCompletion?(user : user, error : nil)
                }, failure: { (operation : AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("Can't find user")
                    self.loginCompletion?(user : nil, error : error)
            })
            
            }) { (error : NSError!) -> Void in
                self.loginCompletion?(user : nil, error : error)
                println("Failed to receive access token")
        }
        
    }
    
    func userHomeTimeline(requestCompletion : (tweets : [Tweet]?, error : NSError?) -> ()) {
        TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            requestCompletion(tweets: tweets, error: nil)
            for tweet in tweets {
                println("home timeline: \(tweet.text)")
            }
            }, failure: { (operation: AFHTTPRequestOperation!, error : NSError!) -> Void in
                requestCompletion(tweets: nil, error: error)
                println("home timeline failure: \(error.description)")
                
        })
    }
   
}
