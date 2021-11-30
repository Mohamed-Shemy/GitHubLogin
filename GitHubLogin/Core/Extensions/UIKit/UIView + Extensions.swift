//
//  UIView + Extensions.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import UIKit

extension UIView {
    
    static var identifier: String { "\(Self.self)" }
    static var nib: UINib { UINib(nibName: identifier, bundle: nil) }
}
