//
//  GitHubNetworkService.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import RxSwift

class GitHubNetworkService: MoyaServiceHelper<GitHubAPI>, GitHubNetworkingServiceProtocol {
    
    func search(with parameters: SearchParameters) -> Single<SearchResponse> {
        request(target: .searchForUsers(parameters))
    }
}
