//
//  StaffSelectAnimator.swift
//  StaffAnimation
//
//  Created by Vadym on 187//17.
//  Copyright © 2017 ua.artjoker. All rights reserved.
//

import UIKit

class StaffSelectAnimator{
    
    private unowned var viewContainer: UIView
    
    init(viewContainer: UIView){
        self.viewContainer = viewContainer
    }
    
    func animate(_ imageView: UIView, destination: CGPoint){
        let imageViewFrame = imageView.convert(imageView.bounds, to: viewContainer)
        imageView.frame = imageViewFrame
        viewContainer.addSubview(imageView)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock{
            imageView.removeFromSuperview()
        }
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: imageViewFrame.origin.x, y: imageViewFrame.origin.y))
        path.addQuadCurve(to: destination, controlPoint: CGPoint(x: 30, y: imageViewFrame.origin.y + imageViewFrame.size.height * 2))
        
        let pathAnimation = CAKeyframeAnimation(keyPath: "position")
        pathAnimation.path = path.cgPath
        pathAnimation.keyTimes = [0.0, 0.8]
        
        let alphaAnimation = CAKeyframeAnimation(keyPath: "opacity")
        alphaAnimation.values = [0.0, 1.0]
        alphaAnimation.keyTimes = [0.0, 0.4]
        
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform")
        scaleAnimation.values = [CATransform3DMakeScale(0.4, 0.4, 1.0), CATransform3DMakeScale(1.0, 1.0, 1.0), CATransform3DMakeScale(0.4, 0.4, 1.0), CATransform3DMakeScale(0.385, 0.385, 1.0)]
        scaleAnimation.keyTimes = [0.0, 0.2, 0.6, 1.0]
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [pathAnimation, alphaAnimation, scaleAnimation]
        groupAnimation.fillMode = kCAFillModeForwards
        groupAnimation.isRemovedOnCompletion = true
        groupAnimation.duration = 0.5
        
        imageView.layer.add(groupAnimation, forKey: nil)
        
        CATransaction.commit()
        
        imageView.alpha = 0
    }
}

