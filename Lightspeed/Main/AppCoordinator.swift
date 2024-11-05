import UIKit
import NavigationKit
import ProductCatalog

final class AppCoordinator {
    
    // MARK: - Properteis
    
    private let navigationService: NavigationServicesLogic
    
    // MARK: - Initialization
    
    init(navigationService: NavigationServicesLogic = NavigationServices.shared) {
        self.navigationService = navigationService
    }
    
    // MARK: - Start

    func start(with windowsScene: UIWindowScene) {
        navigationService.setup(scene: windowsScene, firstVCS: [UIViewController()])
        let initialCoordinator = ProductCatalogCoordinator(navigationService: navigationService)
        initialCoordinator.start(from: .next)
    }
}
