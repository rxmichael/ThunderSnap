//
//  User.swift
//  ChatChat
//
//  Created by blackbriar on 9/14/16.
//  Copyright © 2016 com.teressa. All rights reserved.
//

import Firebase
import Foundation

private let userCache = NSCache()

class User: NSObject {
    var email: String?
    var username: String?
    var partners: [String: AnyObject]?
    var chats: [String: AnyObject]?
    var profile_image: String?
    var uid: String?
    
    class func userFromId(id: String, user: (User) -> ()){
        if let cachedUser = userCache.objectForKey(id) as? User{
            user(cachedUser)
        }
        else{
            let userRef = ref?.child("users/\(id)")
            userRef?.observeSingleEventOfType(.Value, withBlock: { (data) in
                if let userData = data.value as? [String: AnyObject]{
                    let retUser = User()
                    retUser.setValuesForKeysWithDictionary(userData)
                    userCache.setObject(retUser, forKey: id)
                    user(retUser)
                }
                else{
                    fatalError("What went wrong here ?")
                }
            })
        }
    }
    
    class func getCurrentUser(data: (User) -> ()){
        userFromId(currentUser!.uid) { (user) in
            data(user)
        }
        
    }
    
}
