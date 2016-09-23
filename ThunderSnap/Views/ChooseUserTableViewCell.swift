//
//  ChooseUserTableViewCell.swift
//  ChatChat
//
//  Created by blackbriar on 9/14/16.
//  Copyright © 2016 com.teressa. All rights reserved.
//

import UIKit

class ChooseUserTableViewCell: UITableViewCell {
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .ScaleAspectFit
        iv.layer.cornerRadius = 5
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.userInteractionEnabled = true
        return iv
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let textLabel = textLabel
            else{fatalError("opps")}
        guard let detailTextLabel = detailTextLabel
            else{fatalError("opps")}
        
        
        textLabel.frame = CGRectMake(65, textLabel.frame.origin.y, textLabel.frame.width, textLabel.frame.height)
        detailTextLabel.frame = CGRectMake(65, detailTextLabel.frame.origin.y, detailTextLabel.frame.width, detailTextLabel.frame.height)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .whiteColor()
        backgroundColor = .whiteColor()
        contentView.addSubview(profileImageView)
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func layoutViews(){
        
        profileImageView.snp_makeConstraints { (make) in
            make.left.equalTo(contentView.snp_left).offset(12)
            make.centerY.equalTo(contentView.snp_centerY)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutMargins = UIEdgeInsetsZero
        self.preservesSuperviewLayoutMargins = false
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

