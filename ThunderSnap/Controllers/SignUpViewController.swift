//
//  SignUpViewController.swift
//  ChatChat
//
//  Created by blackbriar on 9/14/16.
//  Copyright © 2016 com.teressa. All rights reserved.
//

import UIKit
import Firebase
import SnapKit
import SwiftMessages

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    // - MARK: Views
    
    let logoLabel: UILabel = {
        let ll = UILabel()
        ll.text = "ThunderSnap"
        ll.font = UIFont.boldSystemFontOfSize(18.0)
        ll.textColor = UIColor(hex: 0x0099E8)
        ll.textAlignment = .Center
        return ll
    }()
    
    let logoView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "StartIcon")
        iv.contentMode = .ScaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let fieldsView: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteColor()
        view.layer.cornerRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowRadius = 3.0
        view.layer.shadowColor = UIColor.blackColor().CGColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.userInteractionEnabled = true
        return view
    }()
    
    let usernameField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.autocorrectionType = .No
        tf.autocapitalizationType = .None
        tf.clearButtonMode = .WhileEditing
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.keyboardType = .EmailAddress
        tf.autocorrectionType = .No
        tf.autocapitalizationType = .None
        tf.clearButtonMode = .WhileEditing
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.clearButtonMode = .WhileEditing
        tf.secureTextEntry = true
        return tf
    }()
    
    let usernameSeperatorView: UIView = {
        let sv = UIView()
        sv.backgroundColor = UIColor(hex: 0xEEEEEE)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.userInteractionEnabled = true
        return sv
    }()
    
    let emailSeperatorView: UIView = {
        let sv = UIView()
        sv.backgroundColor = UIColor(hex: 0xEEEEEE)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.userInteractionEnabled = true
        return sv
    }()
    
    let signupButton: UIButton = {
        let bt = UIButton(type: .System)
        bt.backgroundColor = UIColor(hex: 0x0099E8)
        bt.setTitle("Sign Up", forState: .Normal)
        bt.setTitleColor(.whiteColor(), forState: .Normal)
        bt.titleLabel?.font = UIFont.boldSystemFontOfSize(18.0)
        bt.layer.cornerRadius = 5
        bt.layer.masksToBounds = true
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    let back: UIButton = {
        let bt = UIButton(type: .System)
        bt.backgroundColor = .clearColor()
        bt.setTitle("Back to Login", forState: .Normal)
        bt.setTitleColor(.lightGrayColor(), forState: .Normal)
        bt.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
        bt.layer.cornerRadius = 5
        bt.layer.masksToBounds = true
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .whiteColor()
        view.userInteractionEnabled = true
        view.addSubview(logoView)
        view.addSubview(logoLabel)
        view.addSubview(fieldsView)
        view.addSubview(signupButton)
        view.addSubview(back)
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        
        signupButton.addTarget(self, action: #selector(self.signUp), forControlEvents: .TouchUpInside)
        back.addTarget(self, action: #selector(self.backToLogin), forControlEvents: .TouchUpInside)
        
        layoutImage()
        layoutFieldsView()
        layoutButtons()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // - MARK: Layout Functions
    
    func layoutImage() {
        logoView.snp_makeConstraints { (make) in
            make.centerX.equalTo(view.snp_centerX)
            make.bottom.equalTo(logoLabel.snp_top).offset(-15)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        logoLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(view.snp_centerX)
            make.bottom.equalTo(fieldsView.snp_top).offset(-30)
            make.width.equalTo(view.snp_width).offset(-24)
        }
    }
    
    func layoutFieldsView(){
        fieldsView.snp_makeConstraints { (make) in
            make.centerX.equalTo(view.snp_centerX)
            make.centerY.equalTo(view.snp_centerY)
            make.width.equalTo(view.snp_width).offset(-24)
            make.height.equalTo(150)
            
        }
        
        fieldsView.addSubview(usernameField)
        fieldsView.addSubview(emailField)
        fieldsView.addSubview(passwordField)
        fieldsView.addSubview(usernameSeperatorView)
        fieldsView.addSubview(emailSeperatorView)
        
        layoutFields()
    }
    
    func layoutFields(){
        usernameField.snp_makeConstraints { (make) in
            make.left.equalTo(fieldsView.snp_left).offset(12)
            make.right.equalTo(fieldsView.snp_right).offset(-12)
            make.top.equalTo(fieldsView.snp_top)
            make.height.equalTo(fieldsView.snp_height).dividedBy(3)
        }
        
        usernameSeperatorView.snp_makeConstraints { (make) in
            make.left.equalTo(fieldsView.snp_left).offset(12)
            make.right.equalTo(fieldsView.snp_right).offset(-12)
            make.top.equalTo(usernameField.snp_bottom)
            make.height.equalTo(1)
        }
        
        emailField.snp_makeConstraints { (make) in
            make.left.equalTo(fieldsView.snp_left).offset(12)
            make.right.equalTo(fieldsView.snp_right).offset(-12)
            make.top.equalTo(usernameSeperatorView.snp_bottom)
            make.height.equalTo(fieldsView.snp_height).dividedBy(3)
        }
        
        emailSeperatorView.snp_makeConstraints { (make) in
            make.left.equalTo(fieldsView.snp_left).offset(12)
            make.right.equalTo(fieldsView.snp_right).offset(-12)
            make.top.equalTo(emailField.snp_bottom)
            make.height.equalTo(1)
        }
        
        passwordField.snp_makeConstraints { (make) in
            make.left.equalTo(fieldsView.snp_left).offset(12)
            make.right.equalTo(fieldsView.snp_right).offset(-12)
            make.top.equalTo(emailSeperatorView.snp_bottom)
            make.height.equalTo(fieldsView.snp_height).dividedBy(3)
        }
        
    }
    
    func layoutButtons(){
        signupButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(view.snp_centerX)
            make.top.equalTo(fieldsView.snp_bottom).offset(12)
            make.width.equalTo(view.snp_width).offset(-24)
            make.height.equalTo(50)
        }
        back.snp_makeConstraints { (make) in
            make.centerX.equalTo(view.snp_centerX)
            make.top.equalTo(signupButton.snp_bottom).offset(12)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }
    
    
    // - MARK: UIButton Actions
    
    func signUp(){
        if usernameField.text?.isEmpty == false{
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(true, forKey: "Freshman")
            FIRAuth.auth()?.createUserWithEmail(emailField.text!, password: passwordField.text!, completion: { (firUser, error) in
                if error != nil {
                    print(error)
                    let view = MessageView.viewFromNib(layout: .CardView)
                    view.configureDropShadow()
                    let iconText = "😳"
                    view.configureContent(title: "Error", body: self.checkForErrorCode(error), iconText: iconText)
                    view.button!.removeFromSuperview()
                    SwiftMessages.show(view: view)
                }
                else{
                    if let user = firUser{
                        guard let image = UIImage(named: "funny")
                            else{fatalError("You forgot to insert the Image")}
                        guard let imageData = UIImageJPEGRepresentation(image, 0.7)
                            else{fatalError("You've made something wrong here.")}
                        let imageName = NSUUID().UUIDString
                        let profileStorage = storage?.child("\(user.uid)/\(imageName).jpg")
                        profileStorage?.putData(imageData, metadata: nil, completion: { (metaData, error) in
                            if error != nil{
                                // We will try it later again...
                                return
                            }
                            guard let url = metaData?.downloadURL()?.absoluteString
                                else{fatalError("Oops, look at the debugger for more information.")}
                            let userRef = ref?.child("users/\(user.uid)")
                            let userData = [
                                "email": user.email!,
                                "username": self.usernameField.text!,
                                "profile_image": url,
                                "uid": user.uid
                            ]
                            userRef!.setValue(userData)
                        })
                    }
                }
            })
        }
        else{
            let view = MessageView.viewFromNib(layout: .CardView)
            view.configureDropShadow()
            let iconText = "😳"
            view.configureContent(title: "Error", body: "Please enter a username.", iconText: iconText)
            view.button!.removeFromSuperview()
            SwiftMessages.show(view: view)
        }
    }
    
    func backToLogin(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // - MARK: Error Handling
    
    func checkForErrorCode(error: NSError?) -> String{
        
        // Because of any Reason a Switch-Statement won't compile because Xcode says: "ErrorCodeInvalidEmail is no member of FIRAuthErrorCode".
        
        var string = ""
        
        let code = FIRAuthErrorCode(rawValue: error!.code)
        
        if code == FIRAuthErrorCode.ErrorCodeInvalidEmail	{
            string = "Please enter a valid Email."
            return string
        }
        else if code == FIRAuthErrorCode.ErrorCodeEmailAlreadyInUse{
            string = "This Email is already in use."
            return string
        }
        else if code == FIRAuthErrorCode.ErrorCodeWeakPassword{
            string = "This password is too weak. \(error!.userInfo[NSLocalizedFailureReasonErrorKey]!)"
            return string
        }
        else{
            string = "\(error!.localizedDescription)"
            return string
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("SHOULD RETURN ")
        textField.resignFirstResponder()
        return true
    }
    
   override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("TOUCIGIGNFDF ")
        self.view.endEditing(true)
    }
    
}

