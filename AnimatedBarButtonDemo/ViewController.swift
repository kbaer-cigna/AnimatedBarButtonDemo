//
//  ViewController.swift
//  AnimatedBarButtonDemo
//
//  Created by Ken Baer on 7/20/16.
//  Copyright © 2016 M77578. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var rightBarButton: UIBarButtonItem! {
        didSet {
            let icon = UIImage(named: "ChatIcon")
            let iconSize = CGRect(origin: CGPointZero, size: icon!.size)
            let iconButton = UIButton(frame: iconSize)
            iconButton.setBackgroundImage(icon, forState: .Normal)
            rightBarButton?.customView = iconButton
            iconButton.addTarget(self, action: #selector(pushChatView), forControlEvents: .TouchUpInside)
        }
    }
    
    
    @IBAction func spinIcon() {
        rightBarButton.customView!.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 1.0))
        UIView.animateWithDuration(1.0, animations: {self.rightBarButton.customView!.transform = CGAffineTransformIdentity}, completion: nil)
    }
    
    @IBAction func zoomIcon() {
        self.rightBarButton?.customView!.transform = CGAffineTransformMakeScale(0.5, 0.5)
        UIView.animateWithDuration(1.0,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.2,
                                   initialSpringVelocity: 10,
                                   options: .CurveLinear,
                                   animations: {
                                    self.rightBarButton?.customView!.transform = CGAffineTransformMakeScale(1.0, 1.0)
            },
                                   completion: nil)
    }
    
    @IBAction func twistIcon() {
        self.rightBarButton?.customView!.transform = CGAffineTransformMakeRotation(CGFloat(M_PI / 3.0))
        UIView.animateWithDuration(1.0,
                                   delay: 0.5,
                                   usingSpringWithDamping: 0.2,
                                   initialSpringVelocity: 5,
                                   options: .CurveLinear,
                                   animations: {
                                    self.rightBarButton?.customView!.transform = CGAffineTransformIdentity
            },
                                   completion: nil)
    }

    let transition = ZoomViewTransitionManager()

    func pushChatView() {
        
        // this gets a reference to the screen that we're about to transition to
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let toViewController = storyboard.instantiateViewControllerWithIdentifier("ChatView")
        
        toViewController.transitioningDelegate = self
        self.navigationController!.pushViewController(toViewController, animated: true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
 
        self.navigationController?.delegate = self
        self.transitioningDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }

    func navigationController(
        navigationController: UINavigationController,
        animationControllerForOperation operation:
        UINavigationControllerOperation,
                                        fromViewController fromVC: UIViewController,
                                                           toViewController toVC: UIViewController
        ) -> UIViewControllerAnimatedTransitioning? {

        transition.originFrame = self.view.convertRect(self.navigationItem.rightBarButtonItem!.customView!.frame, toView: self.view)
        
        if fromVC is ViewController {
            transition.presenting = true
        }
        else {
            transition.presenting = false
        }
        
        return transition
    }

}
