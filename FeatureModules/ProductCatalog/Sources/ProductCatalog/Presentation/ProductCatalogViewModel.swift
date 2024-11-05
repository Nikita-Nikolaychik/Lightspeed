import Combine

protocol ProductCatalogViewModelLogic {
    var state: AnyPublisher<ProductCatalog.State, Never> { get }
    var event: AnyPublisher<ProductCatalog.Event, Never> { get }
    
    var products: [ProductCatalog.Product] { get }
    
    func viewLoaded()
    func refreshItems()
}

final class ProductCatalogViewModel: ProductCatalogViewModelLogic {
    
    // MARK: - ProductCatalogViewModelLogic properties
    
    var state: AnyPublisher<ProductCatalog.State, Never> { stateSubject.eraseToAnyPublisher() }
    var event: AnyPublisher<ProductCatalog.Event, Never> { eventSubject.eraseToAnyPublisher() }
    
    var products = [ProductCatalog.Product]()
    
    // MARK: - Properties
    
    private let stateSubject = PassthroughSubject<ProductCatalog.State, Never>()
    private let eventSubject = PassthroughSubject<ProductCatalog.Event, Never>()
    
    private let productsRepository: ProductCatalogRepositoryLogic
    
    private let displayProductsSource = DisplayProductCatalogModelSource()
    
    private var dataTask: Task<Void, Never>?
    
    // MARK: - Initialization
    
    init(productsRepository: ProductCatalogRepositoryLogic) {
        self.productsRepository = productsRepository
    }
    
    // MARK: - Actions
    
    func viewLoaded() {
        requestProductCatalog()
    }
    
    func refreshItems() {
        requestProductCatalog()
    }
}

// MARK: - Requests

private extension ProductCatalogViewModel {
    func requestProductCatalog() {
        dataTask?.cancel()
        
        dataTask = Task { @MainActor in
            do {
                let response = try await productsRepository.getProductsCatalog()
                let displayModel = displayProductsSource.prepareDisplayModel(model: response)
                
                products = displayModel.products
                stateSubject.send(.reloadItems)
            } catch {
                stateSubject.send(.loadingFailed)
            }
        }
    }
}
