/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

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

//  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//    return true
//  }
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
                    if freshman == true{
                        let rootView: FreshmanViewController = FreshmanViewController()
                        currentUser = user
                        UIView.transitionWithView(window, duration: 0.5, options: .TransitionCrossDissolve, animations: {
                            window.rootViewController = rootView
                            }, completion: nil)
                    }else{
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

