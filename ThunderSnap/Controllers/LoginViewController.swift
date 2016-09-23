//
//  LohInViewController.swift
//  ChatChat
//
//  Created by blackbriar on 9/14/16.
//  Copyright © 2016 com.teressa. All rights reserved.
//

import UIKit
import Firebase
import SnapKit
import SwiftMessages

class LoginViewController: UIViewController, UITextFieldDelegate {
    
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
        return view
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
    
    let emailSeperatorView: UIView = {
        let sv = UIView()
        sv.backgroundColor = UIColor(hex: 0xEEEEEE)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let loginButton: UIButton = {
        let bt = UIButton(type: .System)
        bt.backgroundColor = UIColor(hex: 0x0099E8)
        bt.setTitle("Login", forState: .Normal)
        bt.setTitleColor(.whiteColor(), forState: .Normal)
        bt.titleLabel?.font = UIFont.boldSystemFontOfSize(18.0)
        bt.layer.cornerRadius = 5
        bt.layer.masksToBounds = true
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    let signupButton: UIButton = {
        let bt = UIButton(type: .System)
        bt.backgroundColor = .clearColor()
        bt.setTitle("Sign Up", forState: .Normal)
        bt.setTitleColor(.lightGrayColor(), forState: .Normal)
        bt.titleLabel?.font = UIFont.boldSystemFontOfSize(16.0)
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
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        emailField.delegate = self
        passwordField.delegate = self
        
        loginButton.addTarget(self, action: #selector(self.login), forControlEvents: .TouchUpInside)
        signupButton.addTarget(self, action: #selector(self.showSignup), forControlEvents: .TouchUpInside)
        
        layoutImage()
        layoutFieldsView()
        layoutButtons()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        emailField.text = ""
        passwordField.text = ""
    }
    
    // -MARK: Layout Functions
    
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
            make.height.equalTo(125)
            
        }
        
        fieldsView.addSubview(emailField)
        fieldsView.addSubview(passwordField)
        fieldsView.addSubview(emailSeperatorView)
        
        layoutFields()
    }
    
    func layoutFields(){
        emailField.snp_makeConstraints { (make) in
            make.left.equalTo(fieldsView.snp_left).offset(12)
            make.right.equalTo(fieldsView.snp_right).offset(-12)
            make.top.equalTo(fieldsView.snp_top)
            make.height.equalTo(fieldsView.snp_height).dividedBy(2)
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
            make.height.equalTo(fieldsView.snp_height).dividedBy(2)
        }
        
    }
    
    func layoutButtons(){
        loginButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(view.snp_centerX)
            make.top.equalTo(fieldsView.snp_bottom).offset(12)
            make.width.equalTo(view.snp_width).offset(-24)
            make.height.equalTo(50)
        }
        
        signupButton.snp_makeConstraints { (make) in
            make.centerX.equalTo(view.snp_centerX)
            make.bottom.equalTo(view.snp_bottom).offset(-12)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
    }
    
    // - MARK: UIButton Actions
    
    func login(){
        if let email = emailField.text, password = passwordField.text{
            FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error) in
                if error != nil {
                    let view = MessageView.viewFromNib(layout: .CardView)
                    view.configureDropShadow()
                    let iconText = "😳"
                    view.configureContent(title: "Error", body: self.checkForErrorCode(error), iconText: iconText)
                    view.button!.removeFromSuperview()
                    SwiftMessages.show(view: view)
                    return
                }
                
                return
                
            })
        }
        else {
            let view = MessageView.viewFromNib(layout: .CardView)
            view.configureDropShadow()
            let iconText = "😳"
            view.configureContent(title: "Error", body: "Please enter an email and password.", iconText: iconText)
            view.button!.removeFromSuperview()
            SwiftMessages.show(view: view)
        }
    }
    
    func showSignup(){
        let svc = SignUpViewController()
        svc.modalTransitionStyle = .CrossDissolve
        presentViewController(svc, animated: true, completion: nil)
    }
    
    
    // - MARK: Error Handling
    
    func checkForErrorCode(error: NSError?) -> String{
        
        // Same like in Signup
        
        var string = ""
        
        let code = FIRAuthErrorCode(rawValue: error!.code)
        
        if code == FIRAuthErrorCode.ErrorCodeOperationNotAllowed{
            string = "User doesn't exist."
            return string
        }
        else if code == FIRAuthErrorCode.ErrorCodeUserDisabled{
            string = "User has been deleted."
            return string
        }
        else if code == FIRAuthErrorCode.ErrorCodeWrongPassword{
            string = "You have entered the wrong password, please try again."
            return string
        }
        else{
            string = "Make sure you have entered an email and password."
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
