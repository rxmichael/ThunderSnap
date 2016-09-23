//
//  HomeViewController.swift
//  ChatChat
//
//  Created by blackbriar on 9/14/16.
//  Copyright © 2016 com.teressa. All rights reserved.
//

import UIKit

import Firebase

class HomeViewController: UIViewController {
    
    
    var chatsRef: FIRDatabaseReference?
    
    var handle: FIRDatabaseHandle?
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor()
        chatsRef = ref?.child("users/\(currentUser!.uid)/chats")
        let logoutItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(logout))
        navigationItem.leftBarButtonItem = logoutItem
        navigationItem.title = "Home"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func logout(){
        try! FIRAuth.auth()?.signOut()
    }
}


