//
//  JSONLoader.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import Foundation

final class JSONLoader {
    
    private init() { }
    
    class func getData(from file: String) -> Data? {
        guard let bundlePath = Bundle.main.path(forResource: file, ofType: "json"),
              let jsonData = try? String(contentsOfFile: bundlePath).data(using: .utf8)
        else {
            return nil
        }
        return jsonData
    }
}
