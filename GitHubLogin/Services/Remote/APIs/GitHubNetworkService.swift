//
//  GitHubNetworkService.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import RxSwift

class GitHubNetworkService: MoyaServiceHelper<GitHubAPI>, GitHubNetworkingServiceProtocol {
    
    func search(forUsers key: String, perPage: Int, page: Int) -> Single<SearchResponse> {
        request(target: .searchForUsers(key, perPage, page))
    }
}
