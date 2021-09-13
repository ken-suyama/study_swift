import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVc()
    }
    
    private func setupVc() {
        let storyboard = UIStoryboard(name: "TimeLine", bundle: nil)
        let viewController: UIViewController = storyboard.instantiateViewController(withIdentifier: "TimeLine")
        let storyboard2 = UIStoryboard(name: "PhotoLibrary", bundle: nil)
        let viewController2: UIViewController = storyboard2.instantiateViewController(withIdentifier: "PhotoLibrary")
        let tabOneBarItem = UITabBarItem(title: "TL", image: UIImage(systemName: "house"), selectedImage: UIImage(named: "selectedImage.png"))
        let tabTwoBarItem = UITabBarItem(title: "PL", image: UIImage(systemName: "photo"), selectedImage: UIImage(named: "selectedImage.png"))
        
        viewController.tabBarItem = tabOneBarItem
        viewController2.tabBarItem = tabTwoBarItem
        self.viewControllers = [viewController, viewController2]
    }
}
