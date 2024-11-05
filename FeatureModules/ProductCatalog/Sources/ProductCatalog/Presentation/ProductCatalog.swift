enum ProductCatalog {
    enum State {
        case loadingFailed
        case reloadItems
    }
    
    enum Event {
        
    }
    
    struct DisplayModel {
        let products: [Product]
    }
    
    struct Product {
        let title: String
        let price: String
        let stock: String
        let thumbnail: String
    }
}
