import Networking

struct ProductCatalogModel: RequestAndResponse {
    typealias Req = EmptyRequest
    typealias Res = ProductsDTO
    
    // MARK: - Settings
    
    var urlPostfix = "/products"
    var methodRequest = RequestMethod.get
    
    var request: EmptyRequest?
    
    // MARK: - Init
    
    init(request: EmptyRequest?) {
        self.request = request
    }
    
    // MARK: - Request & Response
    
    public struct EmptyRequest: Encodable {}
    
    struct ProductsDTO: Decodable {
        let products: [Product]
        let total: Int
        let skip: Int
        let limit: Int
    }
    
    struct Product: Decodable {
        let id: Int
        let title: String
        let description: String
        let category: Category
        let price: Double
        let discountPercentage: Double
        let rating: Double
        let stock: Int
        let tags: [String]
        let brand: String?
        let sku: String
        let weight: Int
        let dimensions: Dimensions
        let warrantyInformation: String
        let shippingInformation: String
        let availabilityStatus: AvailabilityStatus
        let reviews: [Review]
        let returnPolicy: ReturnPolicy
        let minimumOrderQuantity: Int
        let meta: Meta
        let images: [String]
        let thumbnail: String
    }
    
    enum AvailabilityStatus: String, Decodable {
        case inStock = "In Stock"
        case lowStock = "Low Stock"
    }
    
    enum Category: String, Decodable {
        case beauty
        case fragrances
        case furniture
        case groceries
    }
    
    struct Dimensions: Decodable {
        let width: Double
        let height: Double
        let depth: Double
    }
    
    struct Meta: Decodable {
        let createdAt: CreatedAt
        let updatedAt: CreatedAt
        let barcode: String
        let qrCode: String
    }
    
    enum CreatedAt: String, Decodable {
        case the20240523T085621618Z = "2024-05-23T08:56:21.618Z"
        case the20240523T085621619Z = "2024-05-23T08:56:21.619Z"
        case the20240523T085621620Z = "2024-05-23T08:56:21.620Z"
    }
    
    enum ReturnPolicy: String, Decodable {
        case noReturnPolicy = "No return policy"
        case the30DaysReturnPolicy = "30 days return policy"
        case the60DaysReturnPolicy = "60 days return policy"
        case the7DaysReturnPolicy = "7 days return policy"
        case the90DaysReturnPolicy = "90 days return policy"
    }
    
    struct Review: Decodable {
        let rating: Int
        let comment: String
        let date: CreatedAt
        let reviewerName: String
        let reviewerEmail: String
    }
}
