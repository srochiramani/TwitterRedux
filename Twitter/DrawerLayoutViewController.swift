//
//  DrawerLayoutViewController.swift
//  Twitter
//
//  Created by Sunny Rochiramani on 5/31/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

@objc
protocol DrawerLayoutViewControllerDelegate {
    func onHomeSelected()
    func onProfileSelected()
    func onMentionsSelected()
    func closeDrawer()
}

class DrawerLayoutViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var mentionsButton: UIButton!
    
    var delegate : DrawerLayoutViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        homeButton.addTarget(self, action: "onHomeTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        profileButton.addTarget(self, action: "onProfileTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        mentionsButton.addTarget(self, action: "onMentionsTapped:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func onHomeTapped(target : UIButton) {
        println("onHomeTapped")
        delegate?.onHomeSelected()
    }
    
    func onProfileTapped(target: UIButton) {
        println("onProfileTapped")
        delegate?.onProfileSelected()
    }
    
    func onMentionsTapped(target: UIButton) {
        println("onMentionsTapped")
        delegate?.onMentionsSelected()
    }

}
