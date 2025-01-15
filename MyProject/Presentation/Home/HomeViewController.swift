import Foundation
import UIKit
import SnapKit

protocol HomeViewControllerProtocol: AnyObject {
    func goToViewController(research: Researchs)
}

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        view.backgroundColor = .white
        
        setupTabView()
    }
    
    private func setupTabView() {
        let researchsVC = ResearchsViewController()
        researchsVC.delegate = self
        let profileVC = ProfileViewController()
        
        researchsVC.tabBarItem = UITabBarItem(title: "Researchs", image: UIImage(systemName: "house.fill"), tag: 0)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)
        
        viewControllers = [UINavigationController(rootViewController: researchsVC),
                           UINavigationController(rootViewController: profileVC)]
        
        tabBar.tintColor = .greenMint1
        tabBar.backgroundColor = .greenMint5
    }

}

extension HomeViewController: HomeViewControllerProtocol {
    func goToViewController(research: Researchs) {
        switch research{
        case .realm:
            let vc = RealmViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
