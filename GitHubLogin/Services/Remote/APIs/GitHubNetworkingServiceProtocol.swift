//
//  GitHubNetworkingServiceProtocol.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import RxSwift

protocol GitHubNetworkingServiceProtocol: AnyObject {
    
    func search(with parameters: SearchParameters) -> Single<SearchResponse>
}
