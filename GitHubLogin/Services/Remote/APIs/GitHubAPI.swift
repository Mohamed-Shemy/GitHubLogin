//
//  GitHubAPI.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import Moya

enum GitHubAPI {
    
    case searchForUsers(SearchParameters)
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
            case let .searchForUsers(parms):
                var parameters: [String: Any] = [
                    "q": "\(parms.key) in:login",
                    "per_page": parms.perPage,
                    "page": parms.page,
                    "order": parms.order.rawValue]
                if parms.sort != .default {
                    parameters["sort"] = parms.sort.rawValue
                }
                return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}
