//
//  UIImageView+Cache.swift
//  ChatChat
//
//  Created by blackbriar on 9/14/16.
//  Copyright © 2016 com.teressa. All rights reserved.
//

import Foundation
import UIKit

private let cache = NSCache()

extension UIImageView{
    func loadImageFromUrl(urlString: String){
        self.image = nil
        if let cachedImage = cache.objectForKey(urlString) as? UIImage{
            dispatch_async(dispatch_get_main_queue(), {
                
                self.image = cachedImage
            })
            return
        }
        
        let url = NSURL(string: urlString)
        dispatch_async(dispatch_get_main_queue(), {
            self.image =  UIImage(named:"funny")
        })
        NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil {
                fatalError("The debugger is your best friend, \(error?.localizedDescription)")
            }
            else{
                dispatch_async(dispatch_get_main_queue(), {
                    if let newImage = UIImage(data: data!){
                        cache.setObject(newImage, forKey: urlString)
                        self.image = newImage
                        self.backgroundColor = .whiteColor()
                    }
                })
            }
            }.resume()
    }
}
