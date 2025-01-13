import Foundation
import UIKit
import SnapKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupTabView()
    }
    
    private func setupTabView() {
        let researchsVC = ResearchsViewController()
        let profileVC = ProfileViewController()
        
        researchsVC.tabBarItem = UITabBarItem(title: "Researchs", image: UIImage(systemName: "house.fill"), tag: 0)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)
        
        viewControllers = [UINavigationController(rootViewController: researchsVC),
                           UINavigationController(rootViewController: profileVC)]
        
        tabBar.tintColor = .greenMint1
        tabBar.backgroundColor = .greenMint5
    }

}
