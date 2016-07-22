//
//  ZoomViewTransitionManager.swift
//  AnimatedBarButtonDemo
//
//  Created by Ken Baer on 7/21/16.
//  Copyright © 2016 M77578. All rights reserved.
//

import UIKit

class ZoomViewTransitionManager: NSObject, UIViewControllerAnimatedTransitioning {

    var duration = 1.0
    var presenting  = true
    var originFrame = CGRect.zero
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let chatView = presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)!

        let initialFrame = presenting ? originFrame : chatView.frame
        let finalFrame = presenting ? chatView.frame : originFrame
        
        let xScaleFactor = presenting ?
            initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width
        
        let yScaleFactor = presenting ?
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor)
        
        if presenting {
            chatView.transform = scaleTransform
            chatView.center = CGPoint(
                x: CGRectGetMidX(initialFrame),
                y: CGRectGetMidY(initialFrame))
            chatView.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(chatView)
        
        UIView.animateWithDuration(duration,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.4,
                                   initialSpringVelocity: 0,
                                   options: .CurveEaseInOut, //.CurveLinear,
                                   animations: {
                                    chatView.transform = self.presenting ?
                                        CGAffineTransformIdentity : scaleTransform
                                    
                                    chatView.center = CGPoint(x: CGRectGetMidX(finalFrame),
                                        y: CGRectGetMidY(finalFrame))
                                    
            }, completion:{_ in
                transitionContext.completeTransition(true)
        })
        
    }

}
