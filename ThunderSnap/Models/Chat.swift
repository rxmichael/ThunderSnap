//
//  Chat.swift
//  ChatChat
//
//  Created by blackbriar on 9/14/16.
//  Copyright © 2016 com.teressa. All rights reserved.
//

import Foundation
import Firebase


class Chat: NSObject{
    var user1: String?
    var user2: String?
    var chatId: String?
    var lastMessage: String?
    var lastDate: String?
    var lastMessageDate: NSNumber?{
        didSet{
            getDate()
        }
    }
    var partner: String?
    
    
    override func setValuesForKeysWithDictionary(keyedValues: [String : AnyObject]) {
        super.setValuesForKeysWithDictionary(keyedValues)
        if self.user1! == currentUser?.uid{
            self.partner = self.user2!
        }
        else{
            self.partner = self.user1!
        }
        
    }
    
    func getDate(){
        if let date = self.lastMessageDate as? NSTimeInterval{
            let createDate = NSDate(timeIntervalSince1970: date/1000)
            let formatter = NSDateFormatter()
            formatter.dateFormat = "HH:mm"
            self.lastDate = formatter.stringFromDate(createDate)
        }
    }
    
    
    func getImage(imageUrl: (String) -> ()){
        User.userFromId(self.partner!, user: { (user) in
            imageUrl(user.profile_image!)
            
        })
    }
    
    
}
