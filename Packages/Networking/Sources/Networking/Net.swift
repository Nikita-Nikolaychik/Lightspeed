public protocol NetServiceProtocol {
    func send<T: RequestAndResponse>(request: T) async throws -> T.Res
}

public struct Net: NetServiceProtocol {
    
    public init() {}
    
    @discardableResult
    public func send<T: RequestAndResponse>(request: T) async throws -> T.Res {
        return try await NetAwaitService.shared.send(request: request)
    }
}
