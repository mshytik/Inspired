import Foundation

// MARK: Open

extension Optional {
    func open(_ execution: (Wrapped) -> Void) {
        if let unwrapped = self {
            execution(unwrapped)
        }
    }
}

// MARK: Tuned

protocol Tuned { }

extension NSObject: Tuned { }

extension Tuned where Self: Any {
    @discardableResult func tuned(_ execution: (Self) throws -> Void) rethrows -> Self {
        try execution(self)
        return self
    }
}

extension Tuned where Self: AnyObject {
    @discardableResult func tuned(_ execution: (Self) throws -> Void) rethrows -> Self {
        try execution(self)
        return self
    }
}

// MARK: URL

extension URL {
    var queryParameters: [String: String] {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return [:] }
        var parameters: [String: String] = [:]
        queryItems.forEach { parameters[$0.name] = $0.value }
        return parameters
    }
}

extension URLAuthenticationChallenge {
    var isTrusted: Bool {
        return protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust
    }
}

// MARK: GCD

func after(_ time: TimeInterval, _ execute: @escaping Execution) {
    DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: execute)
}

func mainThread(_ execute: @escaping Execution) {
    DispatchQueue.main.async(execute: execute)
}
