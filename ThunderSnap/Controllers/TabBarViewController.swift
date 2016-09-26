//
//  TabBarViewController.swift
//  ThunderSnap
//
//  Created by blackbriar on 9/14/16.
//  Copyright © 2016 com.teressa. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        self.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create Tab one
        let homeTab = HomeNavViewController()
        let hameTabItem = UITabBarItem(title: "Home", image: UIImage(named: "Home"), selectedImage: UIImage(named: "Home filled"))
        
        homeTab.tabBarItem = hameTabItem
        
        
        // Create Tab two
        let chooseTab = ChooseUserNavViewController()
        let chooseTabItem = UITabBarItem(title: "Choose User", image: UIImage(named: "User"), selectedImage: UIImage(named: "User filled"))
        
        chooseTab.tabBarItem = chooseTabItem
        
        tabBar.tintColor = UIColor(hex: 0x0099E8)
        
        tabBar.translucent = false
        
        self.viewControllers = [homeTab, chooseTab]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        
    }
}
