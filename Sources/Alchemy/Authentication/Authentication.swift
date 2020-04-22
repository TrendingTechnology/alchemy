import Foundation

public protocol Authable {
    
}

public struct BasicAuthMiddleware<T: Authable>: Middleware {
    public func intercept(_ input: HTTPRequest) -> T {
        // Load object from DB, authing via username/password
        fatalError()
    }
    
    public init() {}
}

public struct TokenAuthMiddleware<T: Authable>: Middleware {
    public func intercept(_ input: HTTPRequest) -> T {
        // Load object from DB, authing via token
        fatalError()
    }
    
    public init() {}
}
