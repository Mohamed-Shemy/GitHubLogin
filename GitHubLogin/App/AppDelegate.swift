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
        let searchController = SearchViewController()
        coordinator.setRoot(searchController, withNavigation: true)
    }
}

