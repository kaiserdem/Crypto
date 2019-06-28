//
//  AppDelegate.swift
//  Crypto
//
//  Created by Kaiserdem on 18.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit
extension UIApplication {
  var statusBarView: UIView? {
    if responds(to: Selector("statusBar")) {
      return value(forKey: "statusBar") as? UIView
    }
    return nil
  }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  let colors: [UIColor] = [#colorLiteral(red: 0, green: 0.7960784314, blue: 0.7921568627, alpha: 1), #colorLiteral(red: 0.4509803922, green: 0.6862745098, blue: 0.1490196078, alpha: 1)]

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    UIApplication.shared.statusBarStyle = .lightContent
    UIApplication.shared.statusBarView?.backgroundColor = .black
    
    UINavigationBar.appearance().shadowImage = UIImage()
    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    UITabBar.appearance().barTintColor = .black
    
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
  }

  func applicationWillTerminate(_ application: UIApplication) {
  }
}

