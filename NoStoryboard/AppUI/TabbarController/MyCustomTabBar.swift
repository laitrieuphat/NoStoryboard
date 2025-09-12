//
//  MyCustomTabBar.swift
//  NoStoryboard
//
//  Created by Minh on 11/9/25.
//

import UIKit

class MyCustomTabBar: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self // set the delegate to self
        self.tabBar.backgroundColor = .yellow
        
        self.viewControllers = [
            createNavigationController(for: HomeViewController(), title: "Home", image: UIImage(systemName: "house")!),
            createNavigationController(for: LoginViewController(), title: "Profile", image: UIImage(systemName: "person")!),
            createNavigationController(for: ProductDetailViewController(), title: "Settings", image: UIImage(systemName: "gear")!),

        ]
    }
    
    fileprivate func createNavigationController(for rootViewController : UIViewController, title: String, image: UIImage) -> UIViewController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
}
// MARK: - UITabBarControllerDelegate

extension MyCustomTabBar:UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected view controller: \(viewController)")
    }
    
    // Managing tab bar customization
    func tabBarController(_ tabBarController: UITabBarController, willBeginCustomizing viewControllers: [UIViewController]) {
        print("Will begin customizing")
    }
}
