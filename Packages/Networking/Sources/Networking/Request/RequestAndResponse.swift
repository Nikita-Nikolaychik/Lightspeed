import UIKit

public protocol RequestAndResponse {
    
    associatedtype Req: Encodable
    associatedtype Res: Decodable
    
    // MARK: - Request params
    
    var urlPostfix: String { get }
    var methodRequest: RequestMethod { get }
    var request: Req? { get set }
    var response: Res.Type { get }
    
    // MARK: - Init
    
    init(request: Req?)
    
    // MARK: - URL params for request type of get
    
    func toUrl(host: String) -> URL?
}

extension RequestAndResponse {
    public func toUrl(host: String) -> URL? {
        let urlBuilder = URLBuilder(host: host, urlPostfix: urlPostfix)
        return urlBuilder(with: request)
    }
    
    public var response: Res.Type {
        Res.self
    }
}
