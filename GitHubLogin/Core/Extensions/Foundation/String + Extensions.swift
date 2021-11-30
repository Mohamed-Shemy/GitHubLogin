//
//  String + Extensions.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import Foundation

extension String {
    
    var isNotEmpty: Bool { !isEmpty }
    
    var isEmptyOrWhitespace: Bool {
        isEmpty ? true : trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var isNotEmptyOrWhitespace: Bool {
        !isEmptyOrWhitespace
    }
}
