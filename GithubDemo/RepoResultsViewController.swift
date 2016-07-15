//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController {

    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos: [GithubRepo]!
    

    @IBOutlet weak var tableView: UITableView!

    var myTimer = NSTimer()
    var counterTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 110
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
    }

    // Perform the search.
    private func doSearch() {
        print("Do search")
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        print("Min stars: \(searchSettings.minStars)")
        print("langu : \(searchSettings.languages)")
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in
            
            self.repos = newRepos
            self.tableView.reloadData()
            
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navController = segue.destinationViewController as! UINavigationController
        let settingsVC = navController.topViewController as! SettingsViewController
        
        settingsVC.delegate = self
        settingsVC.repoSettings = searchSettings
    }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true;
    }

    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true;
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        myTimer.invalidate()
        searchSettings.searchString = searchText
        myTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(RepoResultsViewController.searchInTime), userInfo: nil, repeats: false)
    }
    func searchInTime(){
        doSearch()
    }
    
}

// MARK: - Implement TableView

extension RepoResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if repos != nil {
            return repos.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! RepoResultsTableViewCell
        cell.repos = repos[indexPath.row]
        return cell
    }
}
//extension RepoResultsViewController: SettingsStarsTableViewCellDelegate {
//    func settingsStarsTableViewCellDelegate(settingsStarsTableViewCell: SettingsStarsTableViewCell, didSelect stars: Float) {
//        print("repoResultsVC got filter from settingVC")
//        
////        let indexPath = tableView.indexPathForSelectedRow
////        searchSettings.minStars = indexPath.
//    }
//}
extension RepoResultsViewController: SettingsViewControllerDelegate {
    func settingsViewController(settingsViewController: SettingsViewController, didSet repoSettings: GithubRepoSearchSettings) {
        print("repoResultsVC got filter from settingVC")
        self.searchSettings = repoSettings
        doSearch()
        
    }
}
