//
//  Collection + Extensions.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import Foundation

extension Collection {
  
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>, _ condition: (T, T) throws -> Bool) rethrows -> [Element] {
        try sorted { try condition($0[keyPath: keyPath], $1[keyPath: keyPath]) }
    }
}
