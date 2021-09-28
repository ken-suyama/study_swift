import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let viewModel: UserViewModel = UserViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        if isNotLoggedIn() {
            viewDidAppear(true)
            return
        }
        viewModel.me()
        setupVc()
//        let appDomain = Bundle.main.bundleIdentifier
//        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isNotLoggedIn() {
            presentLogInView()
        }
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
    
    private func isNotLoggedIn() -> Bool {
        let token = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        print("ログインチェックのやーつ" + token)
        return token == ""
    }
    
    private func presentLogInView() {
        let storyboard: UIStoryboard = UIStoryboard(name: "LogIn", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LogIn") as! LogInViewController
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}
