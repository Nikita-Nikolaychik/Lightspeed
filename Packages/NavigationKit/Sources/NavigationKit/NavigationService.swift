import UIKit

public protocol NavigationServicesLogic {
    func setup(scene: UIWindowScene, firstVCS: [UIViewController])
    func setVC(_ viewController: UIViewController, animated: Bool)
    func pushVC(_ viewController: UIViewController, animated: Bool)
    func popToVC(_ vc: UIViewController, animated: Bool)
    func popVC(animated: Bool)
}

public final class NavigationServices {
    
    // MARK: - Shared instance
    
    public static var shared: NavigationServicesLogic = NavigationServices()
    
    // MARK: Private properties
    
    private let navController = UINavigationController()
    private var window: UIWindow?
    
    // MARK: - Private Methods
    
    private func setup(window: UIWindow, firstVCS: [UIViewController]) {
        self.window = window
        self.navController.viewControllers = firstVCS
        
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}

// MARK: - NavigationServicesLogic

extension NavigationServices: NavigationServicesLogic {
    public func setup(scene: UIWindowScene, firstVCS: [UIViewController]) {
        self.setup(window: UIWindow(windowScene: scene), firstVCS: firstVCS)
    }
    
    public func setVC(_ viewController: UIViewController, animated: Bool = true) {
        self.navController.setViewControllers([viewController], animated: animated)
    }
    
    public func pushVC(_ viewController: UIViewController, animated: Bool = true) {
        self.navController.pushViewController(viewController, animated: animated)
    }
    
    public func popToVC(_ vc: UIViewController, animated: Bool = true) {
        if self.navController.viewControllers.contains(vc) {
            self.navController.popToViewController(vc, animated: animated)
        } else {
            self.navController.popToRootViewController(animated: animated)
        }
    }
    
    public func popVC(animated: Bool = true) {
        self.navController.popViewController(animated: animated)
    }
}
