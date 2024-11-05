import Networking

protocol ProductCatalogRepositoryLogic {
    func getProductsCatalog() async throws -> ProductCatalogModel.Res
}

final class ProductCatalogRepository: ProductCatalogRepositoryLogic {
    
    private let networkService: NetServiceProtocol
    
    init(networkService: NetServiceProtocol) {
        self.networkService = networkService
    }
        
    func getProductsCatalog() async throws -> ProductCatalogModel.Res {
        let requestModel = ProductCatalogModel(request: nil)
        return try await networkService.send(request: requestModel)
    }
}
