//
//  AppCoordinator.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import UIKit

final class AppCoordinator {
    
    static let shared = AppCoordinator()
    
    // MARK: - Properties
    
    private(set) var window: UIWindow?
    
    var rootViewController: UIViewController? {
        window?.rootViewController
    }
    
    var presentedViewController: UIViewController? {
        rootViewController?.presentedViewController
    }
    
    // MARK: - init
    
    private init() { }
    
    // MARK: - Methods
    
    func setWindow(_ window: UIWindow?) {
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    func setRoot(_ viewController: UIViewController, withNavigation: Bool = false) {
        let controller = withNavigation ?
        UINavigationController(rootViewController: viewController) :
        viewController
        
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
    
    func presentOnRoot(_ viewController: UIViewController) {
        rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func dismissKeyboardWhenTap() {
        window?.addGestureRecognizer(
            UITapGestureRecognizer(
                target: window,
                action: #selector(UIWindow.endEditing(_:))
            )
        )
    }
}
