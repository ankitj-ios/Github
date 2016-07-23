//
//  GithubRepositoryCell.swift
//  Github
//
//  Created by Ankit Jasuja on 7/21/16.
//  Copyright © 2016 Ankit Jasuja. All rights reserved.
//

import UIKit

class GithubRepositoryCell: UITableViewCell {
    
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var forkCountLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var loginLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        avatarImageView.layer.cornerRadius = 5
        avatarImageView.clipsToBounds = true
        
        avatarImageView.layer.borderWidth = CGFloat(0.2)
        avatarImageView.layer.borderColor = UIColor.blackColor().CGColor
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
