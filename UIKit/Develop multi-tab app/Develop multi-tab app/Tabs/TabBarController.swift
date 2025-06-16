//
//  TabBarController.swift
//  Develop multi-tab app
//
//  Created by Temur Chitashvili on 16.06.25.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .lightGray
    }
    
    func setupTabs() {
        let onboarding = createNav(
            withTitle: "OnBoarding",
            and: UIImage(systemName: "hand.wave")!,
            vc: OnBoardingViewController()
        )
        
        let profile = createNav(
            withTitle: "Profile",
            and: UIImage(systemName: "person.circle")!,
            vc: ProfileViewController()
        )
        
        let settings = createNav(
            withTitle: "Settings",
            and: UIImage(systemName: "gearshape")!,
            vc: SettingsViewController()
        )
        
        self.setViewControllers([onboarding, profile, settings], animated: true)
    }
    
    private func createNav(
        withTitle title: String,
        and image: UIImage,
        vc: UIViewController
    ) -> UINavigationController {
        let nav  = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        nav.viewControllers.first?.navigationItem.title = title + "Controllers"

        return nav
    }

}
