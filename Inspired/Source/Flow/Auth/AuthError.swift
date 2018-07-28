import Foundation

// MARK: AuthError

struct AuthError {
    
    // MARK: Types
    
    enum Code: Int {
        case unauthorizedClient = 1, denied, unsupportedResponseType, invalidScope, serverError,
        invalidClient, invalidRequest, invalidGrant, temporarilyUnavailable, userCanceledAuth, unknown
    }
    
    // MARK: Static
    
    static let Domain = "com.unsplash.error"
    
    static func error(codeString: String, description: String?) -> NSError {
        var code : Code
        
        switch codeString {
        case "unauthorized_client": code = .unauthorizedClient
        case "access_denied": code = .denied
        case "unsupported_response_type": code = .unsupportedResponseType
        case "invalid_scope": code = .invalidScope
        case "invalid_client": code = .invalidClient
        case "server_error": code = .serverError
        case "temporarily_unavailable": code = .temporarilyUnavailable
        case "invalid_request": code = .invalidRequest
        default: code = .unknown
        }
        
        return error(code: code, description: description)
    }
    
    static func error(code: Code, description: String?) -> NSError {
        var info: Json = [:]
        description.open { info = [NSLocalizedDescriptionKey: $0] }
        return NSError(domain: Domain, code: code.rawValue, userInfo: info)
    }
}
