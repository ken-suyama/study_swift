import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVc()
    }
    
    private func setupVc() {
        let storyboard = UIStoryboard(name: "TimeLine", bundle: nil)
        let viewController: UIViewController = storyboard.instantiateViewController(withIdentifier: "TimeLine")
        let viewController2: UIViewController = UIViewController()
//        viewController.inject(with: dependency)
//        let tabBarController = UITabBarController()
        let tabOneBarItem = UITabBarItem(title: "TL", image: UIImage(systemName: "house"), selectedImage: UIImage(named: "selectedImage.png"))
        
        viewController.tabBarItem = tabOneBarItem
        self.viewControllers = [viewController, viewController2]
    }
}
