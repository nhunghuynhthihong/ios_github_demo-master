//
//  GithubRepoSearchSettings.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import Foundation

// Model class that represents the user's search settings
@objc class GithubRepoSearchSettings: NSObject {
    var searchString: String?
    var minStars = 0
    var languages: [String] = []
    
}