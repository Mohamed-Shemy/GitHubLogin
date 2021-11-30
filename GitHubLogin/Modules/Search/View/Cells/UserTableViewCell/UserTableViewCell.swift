//
//  UserTableViewCell.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import Kingfisher

class UserTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clearData()
    }
    
    // MARK: - Methods
    
    func configure(with user: UserUIModel) {
        avatarImageView.setImage(from: user.avatarURL, placeholder: #imageLiteral(resourceName: "github"))
        loginLabel.text = user.login
        typeLabel.text = user.type
    }
    
    // MARK: - Helpers
    
    private func clearData() {
        avatarImageView.image = #imageLiteral(resourceName: "github")
        loginLabel.text = ""
        typeLabel.text = ""
    }
}
