//
//  ViewController.swift
//  ReplicatorAnimation
//
//  Created by 李潇 on 15/9/2.
//  Copyright (c) 2015年 Daniel_Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var mainLayer = CAReplicatorLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        addJumpAnimation()
    }

    @IBAction func onChangedValue(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            addJumpAnimation()
        case 1:
            addHudAnimation()
        case 2:
            addFollowAnimation()
        default:
            addJumpAnimation()
        }
    }

    func addJumpAnimation() {
        mainLayer.removeFromSuperlayer()

        mainLayer = CAReplicatorLayer()
        mainLayer.bounds = CGRect(x: 0, y: 0, width: 60, height: 60)
        mainLayer.instanceCount = 3
        mainLayer.instanceDelay = 0.33
        mainLayer.instanceTransform = CATransform3DMakeTranslation(20, 0, 0)
        mainLayer.position = view.center
        mainLayer.masksToBounds = true;
        view.layer.addSublayer(mainLayer)

        var layer = CALayer()
        layer.bounds = CGRect(x: 0, y: 0, width: 8, height: 40)
        layer.position = CGPoint(x: 10, y: 75)
        layer.cornerRadius = 2
        layer.backgroundColor = UIColor.redColor().CGColor
        mainLayer.addSublayer(layer)


        var animation = CABasicAnimation(keyPath: "position.y")
        animation.repeatCount = Float.infinity
        animation.toValue = layer.position.y - 25
        animation.autoreverses = true
        animation.duration = 0.5
        layer.addAnimation(animation, forKey: nil)
    }

    func addHudAnimation() {
        mainLayer.removeFromSuperlayer()
        let count = 15
        let angle = CGFloat(2 * M_PI) / CGFloat(count)
        let duration = 1.5

        mainLayer = CAReplicatorLayer()
        mainLayer.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        mainLayer.position = view.center
        mainLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        mainLayer.instanceCount = count
        mainLayer.instanceDelay = duration / Double(count)
        view.layer.addSublayer(mainLayer)

        var layer = CALayer()
        layer.bounds = CGRect(x: 0, y: 0, width: 14, height: 14)
        layer.position = CGPointMake(100, 40)
        layer.borderColor = UIColor.blackColor().CGColor
        layer.backgroundColor = UIColor.grayColor().CGColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 2.0
        mainLayer.addSublayer(layer)

        var animation = CABasicAnimation(keyPath: "transform.scale")
        animation.repeatCount = Float.infinity
        animation.toValue = 0.1
        animation.fromValue = 1
        animation.duration = duration
        layer.addAnimation(animation, forKey: nil)

        layer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01)
    }

    func addFollowAnimation() {
        mainLayer.removeFromSuperlayer()

        mainLayer = CAReplicatorLayer()
        mainLayer.bounds = view.bounds
        mainLayer.position = view.center
        mainLayer.instanceCount = 20
        mainLayer.instanceDelay = 0.1
        mainLayer.instanceColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0).CGColor
        mainLayer.instanceGreenOffset = 0.3
        view.layer.addSublayer(mainLayer)

        var layer = CALayer()
        layer.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
        layer.backgroundColor = UIColor.grayColor().CGColor
        layer.borderColor = UIColor.blackColor().CGColor
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.mainScreen().scale
        mainLayer.addSublayer(layer)

        var animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path()
        animation.repeatCount = Float.infinity
        animation.duration = 4
        layer.addAnimation(animation, forKey: nil)
    }

    func path() -> CGPath {
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(31.5,71.5))
        bezierPath.addLineToPoint(CGPointMake(31.5,23.5))
        bezierPath.addCurveToPoint(CGPointMake(58.5,38.5),controlPoint1:CGPointMake(31.5,23.5),controlPoint2:CGPointMake(62.46,18.69))
        bezierPath.addCurveToPoint(CGPointMake(53.5,45.5),controlPoint1:CGPointMake(57.5,43.5),controlPoint2:CGPointMake(53.5,45.5))
        bezierPath.addLineToPoint(CGPointMake(43.5,48.5))
        bezierPath.addLineToPoint(CGPointMake(53.5,66.5))
        bezierPath.addLineToPoint(CGPointMake(62.5,51.5))
        bezierPath.addLineToPoint(CGPointMake(70.5,66.5))
        bezierPath.addLineToPoint(CGPointMake(86.5,23.5))
        bezierPath.addLineToPoint(CGPointMake(86.5,78.5))
        bezierPath.addLineToPoint(CGPointMake(31.5,78.5))
        bezierPath.addLineToPoint(CGPointMake(31.5,71.5))
        bezierPath.closePath()

        var T = CGAffineTransformMakeScale(3.0,3.0)
        return CGPathCreateCopyByTransformingPath(bezierPath.CGPath, &T)
    }
}

