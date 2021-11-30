//
//  SearchParameters.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import Foundation

struct SearchParameters {
    
    var key: String
    var perPage: Int
    var page: Int
    var sort: SortOption
    var order: SortOrder
}
