//
//  SettingsViewController.swift
//  GithubDemo
//
//  Created by Nhung Huynh on 7/14/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
@objc protocol SettingsViewControllerDelegate {
    optional func settingsViewController(settingsViewController: SettingsViewController,didSet repoSettings: GithubRepoSearchSettings)
}
class SettingsViewController: UIViewController, SettingsViewControllerDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var repoSettings: GithubRepoSearchSettings!
    weak var delegate: SettingsViewControllerDelegate?
    var isFilteredByLanguage = false
    var filterLanguages = [String]()
    var languagues = [["PHP": false], ["Java": false], ["Swift": false]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSave(sender: UIBarButtonItem) {
        self.delegate!.settingsViewController!(self, didSet: repoSettings)
        self.dismissViewControllerAnimated(true, completion: nil)
        
        for language in languagues {
            for (k, v) in language {
                if v == true {
                    repoSettings.languages.append(k)
                }
            }
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

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            if isFilteredByLanguage == true {
            return languagues.count
            } else {
                return 0
            }
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        switch indexPath.section {
            
        case 0:
            // stars setting
            let cell = tableView.dequeueReusableCellWithIdentifier("SettingsStarsCell") as! SettingsStarsTableViewCell
            cell.starSlider.value = Float(repoSettings.minStars)
            cell.starLabel.text = "\(repoSettings.minStars)"
            cell.delegate = self
            return cell
        case 1:
            // filters setting
            let cell = tableView.dequeueReusableCellWithIdentifier("SettingsFiltersCell") as! SettingsFiltersTableViewCell
            cell.delegate = self
            return cell
        case 2:
                let cell = tableView.dequeueReusableCellWithIdentifier("SettingsLanguagesCell")
                for (k, v) in languagues[indexPath.row] {
                    cell?.textLabel?.text = k
                    
                    if v == true {
                        cell!.accessoryType = .Checkmark
                    } else {
                        cell!.accessoryType = .None
                        
                    }
                }
                return cell!
            
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SettingsLanguagesCell")
        for (k, v) in languagues[indexPath.row] {
            languagues[indexPath.row][k] = !languagues[indexPath.row][k]!
            
            tableView.reloadData()
        }
    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        switch section {
//        case 0:
//            let starsHeader = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50))
//            starsHeader.backgroundColor = UIColor.lightGrayColor()
//            return starsHeader
//        case 1:
//            let filterHeader = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 10))
//            filterHeader.backgroundColor = UIColor.lightGrayColor()
//            return filterHeader
//        default:
//            return nil
//        }
//    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 50
        case 1:
            return 20
        case 2:
            return 0
        default:
            20
        }
        return 30
    }
    
}
extension SettingsViewController: SettingsStarsTableViewCellDelegate, SettingsFiltersTableViewCellDelegate {
    func settingsStarsTableViewCellDelegate(settingsStarsTableViewCell: SettingsStarsTableViewCell, didSelect stars: Int) {
        print("settingsVC got the signal from setting stars cell with value \(stars)")
        repoSettings.minStars = stars
//        let indexPath = tableView.indexPathForCell(settingsStarsTableViewCell)
        
    }
    
    func settingsFiltersTableViewCellDelegate(settingsFiltersTableViewCell: SettingsFiltersTableViewCell, didSet filterSwitch: Bool) {
        print("settingsVC got the signal from setting filters cell with value \(filterSwitch)")
        isFilteredByLanguage = filterSwitch
        tableView.reloadData()
        
    }
}
