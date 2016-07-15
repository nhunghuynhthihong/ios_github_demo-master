//
//  SettingsFiltersTableViewCell.swift
//  GithubDemo
//
//  Created by Nhung Huynh on 7/14/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

@objc protocol SettingsFiltersTableViewCellDelegate {
    optional func settingsFiltersTableViewCellDelegate(settingsFiltersTableViewCell: SettingsFiltersTableViewCell, didSet filterSwitch: Bool)
    
}
class SettingsFiltersTableViewCell: UITableViewCell {

    @IBOutlet weak var filtersSwitch: UISwitch!
    
    weak var delegate: SettingsFiltersTableViewCellDelegate?
    var isFilterred = false
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func onSwitch(sender: UISwitch) {
        isFilterred = sender.on
        delegate?.settingsFiltersTableViewCellDelegate!(self, didSet: isFilterred)
    }
}
