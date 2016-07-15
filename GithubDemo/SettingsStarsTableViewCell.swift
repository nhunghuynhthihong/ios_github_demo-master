//
//  SettingsStarsTableViewCell.swift
//  GithubDemo
//
//  Created by Nhung Huynh on 7/14/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

@objc protocol SettingsStarsTableViewCellDelegate {
    optional func settingsStarsTableViewCellDelegate(settingsStarsTableViewCell: SettingsStarsTableViewCell,didSelect stars: Int)
}
class SettingsStarsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var starSlider: UISlider!
    @IBOutlet weak var starLabel: UILabel!
    
    
    weak var delegate: SettingsStarsTableViewCellDelegate?
    var stars: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    @IBAction func sliderValueChanged(sender: UISlider) {
        print(sender.value)
        stars = Int(sender.value)
        starLabel.text = "\(sender.value)"
        delegate?.settingsStarsTableViewCellDelegate?(self, didSelect: stars)
    }
    

}
