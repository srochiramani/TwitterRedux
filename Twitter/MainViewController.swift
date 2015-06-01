//
//  MainViewController.swift
//  Twitter
//
//  Created by Sunny Rochiramani on 5/31/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, BaseTweetTableViewControllerDelegate, DrawerLayoutViewControllerDelegate {
    
    var centerNavigationController: UINavigationController!
    var centerViewController: TweetsViewController!
    
    var drawerViewController : DrawerLayoutViewController?
    
    let centerPanelExpandedOffset: CGFloat = 100
    
    var isDrawerExpanded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerViewController = UIStoryboard.centerViewController()
        centerViewController.delegate = self
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        centerNavigationController.navigationBar.barTintColor = UIColor(red: 0.33, green: 0.674, blue: 0.933, alpha: 0)
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        centerNavigationController.didMoveToParentViewController(self)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    func onHomeSelected() {
        closeDrawer()
        let topControllerObj = centerNavigationController.topViewController
        if let topController = topControllerObj as? TweetsViewController {
            println("Noop. Already at Home")
        } else {
            let vc = storyboard?.instantiateViewControllerWithIdentifier("TweetsViewController") as! UIViewController
            centerNavigationController.pushViewController(vc, animated: true)
        }
    }
    
    func onProfileSelected() {
        closeDrawer()
        let topControllerObj = centerNavigationController.topViewController
        if let topController = topControllerObj as? UserProfileViewController {
            println("Noop. Already at Profile")
        } else {
            let vc = storyboard?.instantiateViewControllerWithIdentifier("UserProfileViewController") as! UserProfileViewController
            vc.user = User.currentUser
            centerNavigationController.pushViewController(vc, animated: true)
        }
    }
    
    func onMentionsSelected() {
        closeDrawer()
        let topControllerObj = centerNavigationController.topViewController
        if let topController = topControllerObj as? MentionsTableViewController {
            println("Noop. Already at Mentions")
        } else {
            let vc = storyboard?.instantiateViewControllerWithIdentifier("MentionsTableViewController") as! MentionsTableViewController
            centerNavigationController.pushViewController(vc, animated: true)
        }
    }
    
    var isValidDrag = true
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        
        let isDraggingFromLeftToRight = (recognizer.velocityInView(view).x > 0)
        
        switch(recognizer.state) {
        case .Began:
            isValidDrag = (!isDrawerExpanded && isDraggingFromLeftToRight) || (isDrawerExpanded && !isDraggingFromLeftToRight)
            if !isDrawerExpanded {
                attachDrawerLayout()
            }
        case .Changed:
            if isValidDrag {
            recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translationInView(view).x
            recognizer.setTranslation(CGPointZero, inView: view)
            }
        case .Ended:
            if isValidDrag {
                if drawerViewController != nil {
                    let hasMovedGreaterThanHalfway = recognizer.view!.center.x > view.bounds.size.width
                    animateDrawer(hasMovedGreaterThanHalfway)
                    }
            }
        default:
            break
        }
        
    }
    
    func openDrawer() {
        println("openDrawer")
        if !isDrawerExpanded {
            attachDrawerLayout()
            animateDrawer(true)
            showShadowForCenterViewController(true)
        }
    }
    
    func attachDrawerLayout() {
        if self.drawerViewController == nil {
            drawerViewController = UIStoryboard.drawerViewController()
            drawerViewController?.delegate = self
            view.insertSubview(drawerViewController!.view, atIndex: 0)
            addChildViewController(drawerViewController!)
            drawerViewController?.didMoveToParentViewController(self)
        }
    }
    
    func closeDrawer() {
        println("closeDrawer")
        if isDrawerExpanded {
            animateDrawer(false)
        }
    }
    
    func animateDrawer(shouldOpen : Bool) {
        var targetPosition : CGFloat!
        if shouldOpen {
            isDrawerExpanded = true
            targetPosition = centerNavigationController.view.frame.width - centerPanelExpandedOffset
        } else {
            isDrawerExpanded = false
            targetPosition = 0
        }
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.centerNavigationController.view.frame.origin.x = targetPosition
        }, completion: nil)
    }
    
    func showShadowForCenterViewController(shouldShowShadow: Bool) {
        if (shouldShowShadow) {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }

}

private extension UIStoryboard {
    class func mainStoryBoard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    }
    
    class func drawerViewController() -> DrawerLayoutViewController {
        return mainStoryBoard().instantiateViewControllerWithIdentifier("DrawerLayoutViewController") as! DrawerLayoutViewController
    }
    
    class func centerViewController() -> TweetsViewController {
        return mainStoryBoard().instantiateViewControllerWithIdentifier("TweetsViewController") as! TweetsViewController
    }
}
