//
//  RepoResultsTableViewCell.swift
//  GithubDemo
//
//  Created by Nhung Huynh on 7/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import AFNetworking

class RepoResultsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    
    var repos: GithubRepo? {
        didSet {
            nameLabel.text = repos?.name
            ownerLabel.text = repos?.ownerHandle
            if let avatarURL = NSURL(string: (repos?.ownerAvatarURL)!) {
                avatarImg.setImageWithURL(avatarURL)
            }
            descriptionLabel.text = repos?.repoDescription
            let stars = repos?.stars ?? 0
            starsLabel.text = "\(stars)"
            let forks = repos?.forks ?? 0
            forksLabel.text = "\(forks)"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
