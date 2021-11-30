//
//  SearchResponse.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import Foundation

struct SearchResponse: Codable {
    
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [User]?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items, message
    }
}
