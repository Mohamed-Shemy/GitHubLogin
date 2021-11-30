//
//  MoyaServiceHelper.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import Moya
import RxSwift

class MoyaServiceHelper<T: TargetType> {
    
    // MARK: - Properties
    
    let provider: MoyaProvider<T>
    
    // MARK: - Init
    
    init(type: NetworkServiceType = .live) {
        let serviceType = type == .live ? MoyaProvider<T>.neverStub : MoyaProvider<T>.immediatelyStub
        var plugins: [PluginType] = []
        
        #if DEBUG
        let formatter = NetworkLoggerPlugin.Configuration.Formatter(responseData: { data in
            data.prettyPrintedJSONString ?? "## invalid json data ##"
        })
        let loggerConfig = NetworkLoggerPlugin.Configuration(formatter: formatter, logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        plugins.append(networkLogger)
        #endif
        
        provider = MoyaProvider<T>(stubClosure: serviceType, plugins: plugins)
    }
    
    // MARK: - Methods

    
    func request<Model: Codable>(target: T) -> Single<Model> {
        return provider.rx
            .request(target)
            .filterSuccessfulStatusAndRedirectCodes()
            .map(Model.self)
    }
}
