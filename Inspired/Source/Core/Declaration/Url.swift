import Foundation

// MARK: Url

enum Url {
    
    // MARK: Types
    
    typealias Route = [String]
    typealias Param = [String: String]
    
    // MARK: Interface
    
    static func make(_ base: String, _ route: Route, _ param: Param = [:]) -> URL? {
        return URL(string: base + routeToken + makeRoute(route) + paramsToken + makeParam(param))
    }
    
    // MARK: Implementation
    
    private static let paramsToken = "?"
    private static let paramToken = "="
    private static let joinToken = "&"
    private static let routeToken = "/"
    
    private static func makeRoute(_ input: Route) -> String {
        return input.joined(separator: routeToken)
    }
    
    private static func makeParam(_ input: Param) -> String {
        return input.map { $0.key + paramToken + $0.value }.joined(separator: joinToken)
    }
}
