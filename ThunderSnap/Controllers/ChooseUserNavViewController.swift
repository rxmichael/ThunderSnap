//
//  ChooseUserNavViewController.swift
//  ChatChat
//
//  Created by blackbriar on 9/14/16.
//  Copyright © 2016 com.teressa. All rights reserved.
//

import UIKit

class ChooseUserNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = ChooseUserViewController()
        vc.title = "Choose Users"
        self.viewControllers = [vc]
        self.title = "Choose Users"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
