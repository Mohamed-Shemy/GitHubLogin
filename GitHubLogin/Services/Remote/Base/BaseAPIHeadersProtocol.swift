//
//  BaseAPIHeadersProtocol.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import Foundation

protocol BaseAPIHeadersProtocol {
    
}

extension BaseAPIHeadersProtocol {
    
    var baseURL: URL {
        URL(string: "https://api.github.com/")!
    }
    
    var headers: [String : String]? {
        ["Content-type": "application/json"]
    }
}
