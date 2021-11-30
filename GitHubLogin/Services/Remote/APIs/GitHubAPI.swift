//
//  GitHubAPI.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import Moya

enum GitHubAPI {
    
    case searchForUsers(_ key: String, _ perPage: Int, _ page: Int)
}

extension GitHubAPI: TargetType, BaseAPIHeadersProtocol {
    
    var path: String {
        switch self {
            case .searchForUsers: return "search/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .searchForUsers: return .get
        }
    }
    
    var task: Task {
        switch self {
            case let .searchForUsers(key, perPage, page):
                let parameters: [String: Any] = [
                    "q": "\(key) in:login",
                    "per_page": perPage,
                    "page": page]
                return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}
