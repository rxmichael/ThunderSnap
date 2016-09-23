//
//  ChooseUserViewController.swift
//  ChatChat
//
//  Created by blackbriar on 9/14/16.
//  Copyright © 2016 com.teressa. All rights reserved.
//

import UIKit
import Firebase

class ChooseUserViewController: UIViewController{
    
    lazy var users = [User]()
    
    var usersRef: FIRDatabaseReference?
    
    lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.registerClass(ChooseUserTableViewCell.self, forCellReuseIdentifier: "cell")
        tb.cellLayoutMarginsFollowReadableWidth = false
        tb.layoutMargins = UIEdgeInsetsZero
        tb.separatorInset = UIEdgeInsetsZero
        tb.dataSource = self
        tb.delegate = self
        return tb
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let rf = UIRefreshControl()
        rf.addTarget(self, action: #selector(self.refreshTable(_:)), forControlEvents: .ValueChanged)
        return rf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        usersRef = ref?.child("users")
        layoutTable()
        observeForUser()
        tableView.addSubview(self.refreshControl)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func layoutTable(){
        tableView.snp_makeConstraints { (make) in
            make.centerX.equalTo(view.snp_centerX)
            make.centerY.equalTo(view.snp_centerY)
            make.width.equalTo(view.snp_width)
            make.height.equalTo(view.snp_height)
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

extension ChooseUserViewController{
    func refreshTable(refreshControl: UIRefreshControl){
        self.refreshControl.beginRefreshing()
        self.usersRef?.removeAllObservers()
        self.users.removeAll(keepCapacity: false)
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
        observeForUser()
    }
}

extension ChooseUserViewController {
    func observeForUser(){
        usersRef?.observeEventType(.ChildAdded, withBlock: { (userSnap) in
            if let userData = userSnap.value as? [String: AnyObject]{
                let user = User()
                user.setValuesForKeysWithDictionary(userData)
                if user.uid! != currentUser!.uid{
                    self.users.append(user)
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                    if self.refreshControl.refreshing == true{
                        self.refreshControl.endRefreshing()
                    }
                })
                
            }
        })
    }
}


extension ChooseUserViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("cell") as? ChooseUserTableViewCell
            else{return UITableViewCell()}
        
        let user = users[indexPath.row]
        
        cell.textLabel!.text = user.username
        cell.detailTextLabel?.text = user.email
        cell.profileImageView.loadImageFromUrl(user.profile_image!)
        cell.profileImageView.layer.cornerRadius =  5
        cell.profileImageView.tag = indexPath.row
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTapOnProfileImage(_:)))
//        tap.delaysTouchesBegan = true
//        cell.profileImageView.addGestureRecognizer(tap)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .Vertical
        let vc = ChatViewController()
        User.userFromId(currentUser!.uid) { (user1) in
            let user = self.users[indexPath.row]
            vc.user = user
            vc.senderImageUrl = user1.profile_image
            vc.senderId = user1.uid
            vc.senderDisplayName = user1.username
            //print("DISPLAY NAME \(currentUser?.displayName)")
            vc.url = user.profile_image
//            vc.user = user
//            vc.url = user.profile_image!
            vc.title = "\(user.username!)"
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }

//        print("USER NAME IS \(user.username)")
//        vc.title = "\(user.username!)"
//        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        vc.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    func handleTapOnProfileImage(sender: UITapGestureRecognizer){
//        if let imageView = sender.view as? UIImageView{
//            let vc = ImageZoomViewController()
//            let user = users[imageView.tag]
//            vc.title = user.username!
//            vc.url = user.profile_image!
//            vc.hidesBottomBarWhenPushed = true
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
    
}




