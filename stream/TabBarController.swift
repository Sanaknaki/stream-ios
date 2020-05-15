//
//  TabBarController.swift
//  stream
//
//  Created by Ali Sanaknaki on 2020-05-13.
//  Copyright © 2020 Ali Sanaknaki. All rights reserved.
//

import UIKit
import Firebase

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
                
        // Check if there's a user logged in, show login view
        if(Auth.auth().currentUser == nil) {
            DispatchQueue.main.async {
                let loginViewController = SignInViewController()
                let navController = UINavigationController(rootViewController: loginViewController)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated:true, completion: nil)
            }
        }
        
        setupViewControllers()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    func setupViewControllers() {
        
        // Home
        let homeViewController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home-unclicked").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "home-clicked").withRenderingMode(.alwaysOriginal), rootViewController: NewHomeViewController())
        
        // List
        let listViewController = templateNavController(unselectedImage: #imageLiteral(resourceName: "list-unclicked").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "list-clicked").withRenderingMode(.alwaysOriginal), rootViewController: ListViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // Takes in an array of Nav Controllers, that show their respective ViewController
        viewControllers = [homeViewController,
                           listViewController]
        
        tabBar.isTranslucent = false
        UITabBar.appearance().barTintColor = .darkPurple()
        tabBar.clipsToBounds = true
        
        // Modify tab bar insets
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: -20, right: 0)
        }
    }
    
    /*
     * Each time you call this, you build a TabBarIcon that links to a ViewController.
     */
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        
        return navController
    }
}

