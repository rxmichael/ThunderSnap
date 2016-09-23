//
//  Room.swift
//  ChatChat
//
//  Created by blackbriar on 9/19/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import Foundation

class Room {
    var id: String!
    var caption: String!
    var thumbnail: String!
    
    init(key: String, snapshot: [String: AnyObject]) {
        self.id = key
        self.caption = snapshot["caption"] as! String
        self.thumbnail = snapshot["fileUrl"] as! String
    }
}