//
//  AppDelegate.swift
//  ProgressHUD
//
//  Created by Sebastian Strus on 2018-06-12.
//  Copyright © 2018 Sebastian Strus. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var hudView: UIVisualEffectView?
    var blureAnimator: UIViewPropertyAnimator?
    var hudLabel: UILabel!
    var circleView: UIView!
    var successView: UIView!
    var errorView: UIView!
    var animation: CABasicAnimation!
    var isHudVisible = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        prepareHUD()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    
    // MARK: - HUD methods
    // prepare own HUD
    func prepareHUD() {
        isHudVisible = false
        let blurEffect = UIBlurEffect(style: .extraLight)
        hudView = UIVisualEffectView(effect: blurEffect)
        hudView?.frame = window?.frame ?? CGRect.zero
        hudLabel = UILabel(frame: CGRect(x: 0, y: (window?.frame.size.height ?? 0.0) / 2 + 40, width: window?.frame.size.width ?? 0.0, height: 100))
        hudLabel?.text = nil
        hudLabel?.textAlignment = .center
        if let aSize = UIFont(name: "American Typewriter", size: 24) {
            hudLabel?.font = aSize
        }
        hudLabel?.numberOfLines = 0
        hudLabel?.adjustsFontSizeToFitWidth = true
        hudLabel?.minimumScaleFactor = 10.0 / 12.0
        hudLabel?.clipsToBounds = true
        hudLabel?.textColor = UIColor.black.withAlphaComponent(0.7)
        hudLabel?.backgroundColor = UIColor.clear
        if let aLabel = hudLabel {
            hudView?.contentView.addSubview(aLabel)
        }
        //success view with checkmark path
        successView = UIView()
        successView?.layer.borderWidth = 2.0
        successView?.layer.borderColor = UIColor.darkGray.cgColor
        successView?.layer.cornerRadius = 50
        successView?.frame = CGRect(x: (window?.frame.size.width ?? 0.0) / 2 - 50, y: (window?.frame.size.height ?? 0.0) / 2 - 70, width: 100, height: 100)
        if let aView = successView {
            hudView?.contentView.addSubview(aView)
        }
        let checkmarkPath = UIBezierPath()
        checkmarkPath.move(to: CGPoint(x: 17, y: 56))
        checkmarkPath.addLine(to: CGPoint(x: 38, y: 76))
        checkmarkPath.addLine(to: CGPoint(x: 83, y: 31))
        checkmarkPath.lineCapStyle = .square
        let checkmarkLayer = CAShapeLayer()
        checkmarkLayer.path = checkmarkPath.cgPath
        checkmarkLayer.fillColor = UIColor.darkGray.cgColor
        successView?.layer.addSublayer(checkmarkLayer)
        //error view with cross path
        errorView = UIView()
        errorView?.layer.borderWidth = 2.0
        errorView?.layer.borderColor = UIColor.darkGray.cgColor
        errorView?.layer.cornerRadius = 50
        errorView?.frame = CGRect(x: (window?.frame.size.width ?? 0.0) / 2 - 50, y: (window?.frame.size.height ?? 0.0) / 2 - 70, width: 100, height: 100)
        if let aView = errorView {
            hudView?.contentView.addSubview(aView)
        }
        let crossPath = UIBezierPath()
        crossPath.move(to: CGPoint(x: (errorView?.bounds.width)! * 0.72, y: (errorView?.bounds.height)! * 0.27))
        crossPath.addLine(to: CGPoint(x: (errorView?.bounds.width)! * 0.27, y: (errorView?.bounds.height)! * 0.72))
        crossPath.move(to: CGPoint(x: (errorView?.bounds.width)! * 0.27, y: (errorView?.bounds.height)! * 0.27))
        crossPath.addLine(to: CGPoint(x: (errorView?.bounds.width)! * 0.72, y: (errorView?.bounds.height)! * 0.72))
        crossPath.lineCapStyle = .square
        let crossLayer = CAShapeLayer()
        crossLayer.path = crossPath.cgPath
        crossLayer.fillColor = nil
        crossLayer.strokeColor = UIColor.darkGray.cgColor
        crossLayer.lineWidth = 2.0
        errorView?.layer.addSublayer(crossLayer)
        //circle view with 3 point
        circleView = UIView()
        circleView?.layer.borderWidth = 2.0
        circleView?.layer.borderColor = UIColor.darkGray.cgColor
        circleView?.layer.cornerRadius = 50
        circleView?.layer.shadowOpacity = 0.8
        circleView?.layer.shadowRadius = 10.0
        circleView?.frame = CGRect(x: (window?.frame.size.width ?? 0.0) / 2 - 50, y: (window?.frame.size.height ?? 0.0) / 2 - 70, width: 100, height: 100)
        if let aView = circleView {
            hudView?.contentView.addSubview(aView)
        }
        //first point
        let pointView = UIView()
        pointView.frame = CGRect(x: 45, y: -4, width: 10, height: 10)
        pointView.layer.cornerRadius = 5
        pointView.backgroundColor = UIColor.darkGray
        pointView.layer.borderColor = UIColor.darkGray.cgColor
        pointView.layer.shadowColor = UIColor.darkGray.cgColor
        pointView.layer.shadowOpacity = 1.0
        pointView.layer.shadowRadius = 3.0
        let path = UIBezierPath()
        path.move(to: CGPoint(x: -23, y: 9))
        path.addLine(to: CGPoint(x: 6, y: 0))
        path.addLine(to: CGPoint(x: 6, y: 10))
        path.addLine(to: CGPoint(x: -23, y: 9))
        path.close()
        pointView.layer.shadowPath = path.cgPath
        pointView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        circleView?.addSubview(pointView)
        // second point
        let pointView2 = UIView()
        pointView2.frame = CGRect(x: 87, y: 70, width: 10, height: 10)
        pointView2.layer.cornerRadius = 5
        pointView2.backgroundColor = UIColor.darkGray
        pointView2.layer.borderColor = UIColor.darkGray.cgColor
        pointView2.layer.shadowColor = UIColor.darkGray.cgColor
        pointView2.layer.shadowOpacity = 1.0
        pointView2.layer.shadowRadius = 3.0
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: 15, y: -25))
        path2.addLine(to: CGPoint(x: 9, y: 9))
        path2.addLine(to: CGPoint(x: 1, y: 7))
        path2.addLine(to: CGPoint(x: 15, y: -25))
        path2.close()
        pointView2.layer.shadowPath = path2.cgPath
        pointView2.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        circleView?.addSubview(pointView2)
        // third point
        let pointView3 = UIView()
        pointView3.frame = CGRect(x: 2, y: 70, width: 10, height: 10)
        pointView3.layer.cornerRadius = 5
        pointView3.backgroundColor = UIColor.darkGray
        pointView3.layer.borderColor = UIColor.darkGray.cgColor
        pointView3.layer.shadowColor = UIColor.darkGray.cgColor
        pointView3.layer.shadowOpacity = 1.0
        pointView3.layer.shadowRadius = 3.0
        let path3 = UIBezierPath()
        path3.move(to: CGPoint(x: 29, y: 29))
        path3.addLine(to: CGPoint(x: 1, y: 9))
        path3.addLine(to: CGPoint(x: 9, y: 5))
        path3.addLine(to: CGPoint(x: 29, y: 29))
        path3.close()
        pointView3.layer.shadowPath = path3.cgPath
        pointView3.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        circleView?.addSubview(pointView3)
        //animation for the circle
        animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation?.fromValue = 0.0
        animation?.toValue = 2 * Double.pi
        animation?.duration = 1.1
        animation?.repeatCount = .infinity
        if let anAnimation = animation {
            circleView?.layer.add(anAnimation, forKey: "spinAnimation")
        }
        hudView?.alpha = 0.0
        if let aView = hudView {
            window?.rootViewController?.view.addSubview(aView)
        }
        // ! it is possible to make less blure in the background but it couses problems when application applicationDidEnterBackground. Instead it is better to use screenshoot picture and make it blurred.
        blureAnimator = UIViewPropertyAnimator(duration: 1.0, curve: UIView.AnimationCurve.linear, animations: {
            self.hudView?.effect = nil
        })
        
        blureAnimator?.fractionComplete = 0.15;
    }
    
    
    @objc func showOrUpdateHUD(withText text: String?) {
        hudLabel?.text = text
        hudView?.alpha = 1.0
        successView?.alpha = 0.0
        errorView?.alpha = 0.0
        circleView?.alpha = 1.0
        isHudVisible = true
    }
    
    @objc func showSuccess(withText text: String?) {
        hudLabel?.text = text
        hudView?.alpha = 1.0
        successView?.alpha = 1.0
        errorView?.alpha = 0.0
        circleView?.alpha = 0.0
        isHudVisible = true
    }
    
    @objc func showError(withText text: String?) {
        hudLabel?.text = text
        hudView?.alpha = 1.0
        errorView?.alpha = 1.0
        successView?.alpha = 0.0
        circleView?.alpha = 0.0
        isHudVisible = true
    }
    
    @objc func dismissHUD() {
        //[_blureAnimator stopAnimation:YES];
        hudLabel?.text = nil
        isHudVisible = false
        UIView.animate(withDuration: 0.5) {
            self.hudView?.alpha = 0.0
        }
    }
    
    
}

