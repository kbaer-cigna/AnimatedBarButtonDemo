//
//  ZoomPresentViewTransition.swift
//  AnimatedBarButtonDemo
//
//  Created by M77578 on 7/21/16.
//  Copyright © 2016 M77578. All rights reserved.
//

import UIKit

class ZoomPresentViewTransition: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 2.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            let containerView = transitionContext.containerView(),
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
                return
        }
        
        let initialFrame = toVC.view.frame
        let finalFrame = transitionContext.finalFrameForViewController(toVC)
        
        guard let iconFrame = fromVC.navigationItem.rightBarButtonItem?.customView?.frame else { return }
        let xFactor = iconFrame.size.width / initialFrame.size.width
        let yFactor = iconFrame.size.height / initialFrame.size.height
        
        let duration = transitionDuration(transitionContext)
        
        UIView.animateKeyframesWithDuration(
            duration,
            delay: 0,
            options: .CalculationModeCubic,
            animations: {
                UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1/3, animations: {
                    fromVC.view.layer.transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor)
                })
                
            },
            completion: { _ in
                toVC.view.hidden = false
                fromVC.view.layer.transform = AnimationHelper.yRotation(0.0)
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })

    }

}
