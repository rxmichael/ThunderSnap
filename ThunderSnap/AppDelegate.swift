//
//  AppDelegate.swift
//  ThunderSnap
//
//  Created by blackbriar on 9/14/16.
//  Copyright © 2016 com.teressa. All rights reserved.
//

import UIKit
import Firebase

var ref: FIRDatabaseReference?
var storage: FIRStorageReference?
var currentUser: FIRUser?
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  override init() {
    FIRApp.configure()
    FIRDatabase.database().persistenceEnabled = true
  }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        ref = FIRDatabase.database().reference()
        
        storage = FIRStorage.storage().reference()
        
        if let window = self.window {
            // Change the backgroundColor to make the presentation of the root view controller look smoother
            window.backgroundColor = .whiteColor()
            FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
                if let user = user {
                    // This worked out because when I set the rootViewController in the animation, the navigation bar slides down from status bar...
                    let defaults = NSUserDefaults.standardUserDefaults()
                    let freshman = defaults.boolForKey("Freshman")
                    if freshman == true {
                        let rootView: FreshmanViewController = FreshmanViewController()
                        currentUser = user
                        UIView.transitionWithView(window, duration: 0.5, options: .TransitionCrossDissolve, animations: {
                            window.rootViewController = rootView
                            }, completion: nil)
                    } else {
                        currentUser = user
                        let tabBarController = TabBarViewController()
                        window.rootViewController = tabBarController
                    }
                } else {
                    let rootView: LoginViewController = LoginViewController()
                    UIView.transitionWithView(window, duration: 0.5, options: .TransitionCrossDissolve, animations: {
                        window.rootViewController = rootView
                        }, completion: nil)
                }
            }
        }
        return true
    }


}

