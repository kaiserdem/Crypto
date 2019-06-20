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

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    UITabBar.appearance().barTintColor = .black
    UIApplication.shared.statusBarView?.backgroundColor = .black
    application.statusBarStyle = .lightContent

   // echoTest()
    
    return true
  }
  func echoTest(){
    
    var messageNum = 0
    let ws = WebSocket("wss://demo.cryptto.io:8777")
    let send : ()->() = {
      messageNum += 1
      let msg = "\(messageNum): \(NSDate().description)"
      print("send: \(msg)")
      ws.send(msg)
    }
    ws.event.open = {
      print("opened")
      send()
    }
    ws.event.close = { code, reason, clean in
      print("close")
    }
    ws.event.error = { error in
      print("error \(error)")
    }
    ws.event.message = { message in
      if let text = message as? String {
        print("recv: \(text)")
        if messageNum == 10 {
          ws.close()
        } else {
          send()
        }
      }
    }
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


}

