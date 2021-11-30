//
//  GitHubNetworkingServiceProtocol.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import RxSwift

protocol GitHubNetworkingServiceProtocol: AnyObject {
    
    func search(forUsers key: String, perPage: Int, page: Int) -> Single<SearchResponse>
}
