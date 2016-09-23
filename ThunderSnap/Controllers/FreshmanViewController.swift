//
//  FreshmanViewController.swift
//  ChatChat
//
//  Created by blackbriar on 9/14/16.
//  Copyright © 2016 com.teressa. All rights reserved.
//
import UIKit
import ALCameraViewController
import Firebase
import SwiftMessages

final class FreshmanViewController: UIViewController {
    
    var image: UIImage?
    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Here you can choose a profile picture or stick with the funny one below."
        lb.textAlignment = .Center
        lb.textColor = .darkGrayColor()
        lb.font = UIFont.boldSystemFontOfSize(16.0)
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "funny")
        iv.contentMode = .ScaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let finish: UIButton = {
        let bt = UIButton(type: .System)
        bt.backgroundColor = UIColor(hex: 0x0099E8)
        bt.setTitle("Finish", forState: .Normal)
        bt.setTitleColor(.whiteColor(), forState: .Normal)
        bt.titleLabel?.font = UIFont.boldSystemFontOfSize(18.0)
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    let edit: UIButton = {
        let bt = UIButton(type: .System)
        bt.backgroundColor = .clearColor()
        bt.setTitle("Edit", forState: .Normal)
        bt.setTitleColor(UIColor(hex: 0x0099E8), forState: .Normal)
        bt.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .whiteColor()
        
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(finish)
        view.addSubview(edit)
        
        edit.addTarget(self, action: #selector(self.showPicker), forControlEvents: .TouchUpInside)
        finish.addTarget(self, action: #selector(finishAction), forControlEvents: .TouchUpInside)
        
        image = UIImage(named: "funny")
        
        setupViews()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func finishAction(){
        guard let image = self.image
            else{fatalError("You forgot to insert the Image")}
        guard let imageData = UIImageJPEGRepresentation(image, 0.7)
            else{fatalError("You've made something wrong here.")}
        guard let currentUser = FIRAuth.auth()?.currentUser
            else{fatalError("No active user… We have a lack somewhere.")}
        let imageName = NSUUID().UUIDString
        let profileStorage = storage?.child("\(currentUser.uid)/\(imageName).jpg")
        profileStorage?.putData(imageData, metadata: nil, completion: { (metaData, error) in
            if error != nil {
                let view = MessageView.viewFromNib(layout: .CardView)
                view.configureDropShadow()
                let iconText = "😳"
                view.configureContent(title: "Error", body: "Please try another image.", iconText: iconText)
                view.button!.removeFromSuperview()
                SwiftMessages.show(view: view)
            }
            else{
                guard let url = metaData?.downloadURL()?.absoluteString
                    else{fatalError("Look at the debugger for more information...")}
                let userRef = ref?.child("users/\(currentUser.uid)/profile_image")
                userRef?.setValue(url)
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setBool(false, forKey: "Freshman")
                let rootTab = TabBarViewController()
                rootTab.modalTransitionStyle = .CrossDissolve
                self.presentViewController(rootTab, animated: true, completion: nil)
                
            }
        })
    }
    
    func showPicker(){
        let croppingEnabled = true
        let cameraViewController = CameraViewController(croppingEnabled: croppingEnabled) { [weak self] image, asset in
            if let image = image{
                self!.imageView.image = image
                self!.image = image
                
                self?.dismissViewControllerAnimated(true, completion: nil)
            }
            else{
                self!.imageView.image = self?.image
                self?.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        presentViewController(cameraViewController, animated: true, completion: nil)
    }
    
    func setupViews(){
        
        imageView.snp_makeConstraints { (make) in
            make.centerX.equalTo(view.snp_centerX)
            make.bottom.equalTo(edit.snp_top)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(view.snp_top).offset(55)
            make.centerX.equalTo(view.snp_centerX)
            make.width.equalTo(view.snp_width).offset(-24)
        }
        
        edit.snp_makeConstraints { (make) in
            make.centerY.equalTo(view.snp_centerY).offset(40)
            make.centerX.equalTo(view.snp_centerX)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        finish.snp_makeConstraints { (make) in
            make.bottom.equalTo(view.snp_bottom)
            make.centerX.equalTo(view.snp_centerX)
            make.width.equalTo(view.snp_width)
            make.height.equalTo(75)
        }
        
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