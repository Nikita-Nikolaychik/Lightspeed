import UIKit
import Combine
import Networking
import NavigationKit

public final class ProductCatalogCoordinator {
    
    // MARK: - Properties
    
    private let navigationService: NavigationServicesLogic
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    
    public init(
        navigationService: NavigationServicesLogic
    ) {
        self.navigationService = navigationService
    }
    
    // MARK: - Start
    
    public func start(from: EntryPoint) {
        switch from {
        case .next:
            openProductCatalogScreen()
        }
    }
}

// MARK: - Screens

private extension ProductCatalogCoordinator {
    func openProductCatalogScreen() {
        let viewModel = ProductCatalogViewModel(productsRepository: ProductCatalogRepository(networkService: Net()))
        let viewController = ProductCatalogController(viewModel: viewModel)
        viewModel.event
            .sink { event in
                // some navigation handling
            }
            .store(in: &cancellables)
        
        navigationService.setVC(viewController, animated: false)
    }
}

// MARK: - Entry Point

extension ProductCatalogCoordinator {
    public enum EntryPoint {
        case next
    }
}
