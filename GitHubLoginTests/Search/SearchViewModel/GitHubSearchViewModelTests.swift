//
//  GitHubSearchViewModelTests.swift
//  GitHubLoginTests
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import GitHubLogin

class GitHubSearchViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: GitHubSearchViewModel!
    var scheduler: TestScheduler!
    
    // MARK: - Life Cycle
    
    override func setUpWithError() throws {
        self.scheduler = TestScheduler(initialClock: 0)
        let service = GitHubNetworkService(type: .test)
        self.viewModel = GitHubSearchViewModel(githubService: service)
    }
    
    override func tearDownWithError() throws {
        self.viewModel = nil
    }
    
    // MARK: - Test Cases
    
    func testEmptyText() {
        let users = scheduler.createObserver([User].self)
        viewModel.users
            .asDriver().drive(users)
            .disposed(by: viewModel.disposeBag)
        viewModel.search(for: "")
        let usersCount = users.events.last?.value.element?.count ?? 0
        XCTAssertEqual(usersCount, 0, "Users must be == \(0) not \(usersCount)")
    }
    
    func testSearchSameKey() {
        let count = viewModel.usersPerPage
        let users = scheduler.createObserver([User].self)
        viewModel.users
            .asDriver().drive(users)
            .disposed(by: viewModel.disposeBag)
        viewModel.search(for: "mohamed")
        viewModel.search(for: "mohamed")
        scheduler.start()
        let usersCount = users.events.last?.value.element?.count ?? 0
        XCTAssertEqual(usersCount, count, "Users must be == \(count) not \(usersCount)")
    }
    
    func testGetPageOne() {
        let count = viewModel.usersPerPage
        let users = scheduler.createObserver([User].self)
        viewModel.users
            .asDriver().drive(users)
            .disposed(by: viewModel.disposeBag)
        viewModel.search(for: "mohamed")
        scheduler.start()
        let usersCount = users.events.last?.value.element?.count ?? 0
        XCTAssertEqual(usersCount, count, "Users must be == \(count) not \(usersCount)")
    }
    
    func testGetPageThree() {
        let count = viewModel.usersPerPage * 3
        let users = scheduler.createObserver([User].self)
        viewModel.users
            .asDriver().drive(users)
            .disposed(by: viewModel.disposeBag)
        
        viewModel.search(for: "mohamed")
        viewModel.getNextPage()
        viewModel.getNextPage()
        
        scheduler.start()
        let usersCount = users.events.last?.value.element?.count ?? 0
        XCTAssertEqual(usersCount, count, "Users must be == \(count) not \(usersCount)")
    }
    
    func testGetNotExsitPage() {
        let error = scheduler.createObserver(String?.self)
        viewModel.error
            .asDriver(onErrorJustReturn: "Error").drive(error)
            .disposed(by: viewModel.disposeBag)
        
        viewModel.search(for: "mohamed")
        viewModel.getNextPage()
        viewModel.getNextPage()
        viewModel.getNextPage()
        
        scheduler.start()
        let message = error.events.last?.value.element as Any?
        XCTAssertNotNil(message, "no error message")
    }
    
    func testStopNextPage() {
        let count = viewModel.usersPerPage
        let users = scheduler.createObserver([User].self)
        viewModel.users
            .asDriver().drive(users)
            .disposed(by: viewModel.disposeBag)
        viewModel.search(for: "mohamed")
        viewModel.isLoading.accept(true)
        viewModel.getNextPage()
        scheduler.start()
        let usersCount = users.events.last?.value.element?.count ?? 0
        XCTAssertEqual(usersCount, count, "Users must be == \(count) not \(usersCount)")
    }
}
