//
//  User.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import Foundation

struct User: Codable {
    
    let login, nodeID,
        avatarURL, gravatarID,
        url, htmlURL,
        followersURL, followingURL,
        gistsURL, starredURL,
        subscriptionsURL, organizationsURL,
        reposURL, eventsURL, receivedEventsURL,
        type: String?
    let id, score: Int?
    let siteAdmin: Bool?
    
    enum CodingKeys: String, CodingKey {
        case login, id, url, type, score
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case siteAdmin = "site_admin"
    }
}

extension User {
    
    var uiModel: UserUIModel? {
        guard let login = login,
              let avatarURL = avatarURL,
              let type = type
        else { return nil }
        return UserUIModel(login: login, avatarURL: avatarURL, type: type)
    }
}
