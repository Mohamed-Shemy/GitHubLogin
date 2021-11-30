//
//  GitHubSearchViewModel.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import Foundation
import RxSwift
import RxRelay

final class GitHubSearchViewModel {
    
    // MARK: - Properties
    
    private let githubService: GitHubNetworkingServiceProtocol
    
    let disposeBag = DisposeBag()
    let users = BehaviorRelay<[User]>(value: [])
    let isLoading = BehaviorRelay<Bool>(value: false)
    let error = PublishSubject<String>()
    
    let searchText = BehaviorRelay<String>(value: "")
    let submitButtonTapped = PublishSubject<Void>()
    
    private var lastSearchKey = ""
    private let usersPerPage = 9
    private var currentPage = 1
    private var totalResults = 0
    private var remainingResults: Int {
        totalResults - (usersPerPage * currentPage)
    }
    
        // MARK: - init
    
    // accept any Service confirm to GitHubNetworkingServiceProtocol
    init(githubService: GitHubNetworkingServiceProtocol = GitHubNetworkService()) {
        self.githubService = githubService
        
        submitButtonTapped.subscribe(onNext: { [weak self] in
            self?.searchWithCurrentKey()
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    
    func search(for key: String) {
        // remove whitespaces & check if is not empty
        // to avoid calling the empty request
        let key = key.trimmingCharacters(in: .whitespaces)
        guard key.isNotEmptyOrWhitespace else {
            users.accept([])
            return
        }
        
        // assert that the new search key not equal the the last one
        // to avoid calling the same request
        guard key != lastSearchKey else { return }
        lastSearchKey = key
        currentPage = 1
        performSearch(for: key)
    }
    
    func getNextPage() {
        // check if there are more pages
        // and is not loading a page
        // to avoid the collision between requests
        guard remainingResults > 0, !isLoading.value else { return }
        currentPage += 1
        performSearch(for: lastSearchKey, appendResult: true)
    }
    
    // MARK: - Helpers
    
    private func searchWithCurrentKey() {
        search(for: searchText.value)
    }
    
    // appendResult:
    //   - if this a new search -> replace old result
    //   - if getting new page -> append result
    private func performSearch(for key: String, appendResult: Bool = false) {
        isLoading.accept(true)
        githubService.search(forUsers: key, perPage: usersPerPage, page: currentPage)
            .subscribe { [weak self] response in
                guard let self = self else { return }
                self.isLoading.accept(false)
                
                // get users & handle error message
                guard let users = response.items else {
                    self.error.onNext(response.message ?? "Something wrong, please try again later!")
                    return
                }
                
                // set new data
                self.totalResults = response.totalCount ?? 0
                if appendResult {
                    var allUsers = self.users.value
                    allUsers.append(contentsOf: users)
                    self.users.accept(allUsers)
                } else {
                    self.users.accept(users)
                }
                
            } onFailure: { [weak self] error in
                self?.isLoading.accept(false)
                self?.totalResults = 0
                self?.error.onNext(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
}
