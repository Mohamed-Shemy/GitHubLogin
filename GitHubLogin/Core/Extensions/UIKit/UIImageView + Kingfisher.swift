//
//  UIImageView + Kingfisher.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import Kingfisher

extension UIImageView {
    
    func setImage(from stringURL: String, placeholder: UIImage? = nil) {
        let url = URL(string: stringURL)
        kf.indicatorType = .activity
        kf.setImage(with: url, placeholder: placeholder,
                    options: [.cacheOriginalImage, .transition(.fade(0.25))])
    }
}
