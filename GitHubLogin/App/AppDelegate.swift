//
//  AppDelegate.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    
    private let coordinator = AppCoordinator.shared
    
    // MARK: - Life Cycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setDefaultWindow()
        displayFirstScreen()
        
        return true
    }
    
    // MARK: - Helper Methods
    
    private func setDefaultWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        coordinator.setWindow(window)
        coordinator.dismissKeyboardWhenTap()
    }
    
    private func displayFirstScreen() {
        let viewModel = getGitHubSearchViewModel()
        let searchController = SearchViewController(viewModel: viewModel)
        AppCoordinator.shared.setRoot(searchController, withNavigation: true)
    }
    
    private func getGitHubSearchViewModel() -> GitHubSearchViewModel {
        if CommandLine.arguments.contains("--uitesting") {
            let service = GitHubNetworkService(type: .test)
            return GitHubSearchViewModel(githubService: service)
        }
        return GitHubSearchViewModel()
    }
}

