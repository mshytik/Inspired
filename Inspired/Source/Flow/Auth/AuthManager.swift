import UIKit

// MARK: AuthManager

final class AuthManager {
    
    // MARK: Types
    
    struct AccessToken: CustomStringConvertible {
        let appId: String
        let accessToken: String
        var description: String { return accessToken }
    }
    
    typealias Api = Path.Unsplash.Base
    typealias TokenCompletion = (AccessToken?, NSError?) -> Void
    
    // MARK: Static
    
    static let shared = AuthManager(appId: Api.key, secret: Api.secret, scopes: ["public", "read_user"])
    
    private static let publicScope = ["public"]
    private static let allScopes = ["public",
                                    "read_user",
                                    "write_user",
                                    "read_photos",
                                    "write_photos",
                                    "write_likes",
                                    "read_collections",
                                    "write_collections"]
    
    // MARK: Properties
    
    var accessToken: AccessToken? {
        guard let token = Keychain.get(key: appId) else { return nil }
        return AccessToken(appId: appId, accessToken: token)
    }
    
    private let appId: String
    private let secret: String
    private let redirectURL: URL
    private let scopes: [String]
    
    var redirectEscaped: String {
        return (redirectURL.absoluteString as NSString).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    private var authUrl: URL? {
        let components = NSURLComponents().tuned {
            $0.scheme = "https"
            $0.host = "unsplash.com"
            $0.path = "/oauth/authorize"
            $0.queryItems = [URLQueryItem(name: "response_type", value: "code"),
                             URLQueryItem(name: "client_id", value: appId),
                             URLQueryItem(name: "redirect_uri", value: "urn:ietf:wg:oauth:2.0:oob"),
                             URLQueryItem(name: "scope", value: scopes.joined(separator: "+"))]
        }
        return components.url
    }
    
    private func accessTokenUrl(code: String) -> URL? {
        let components = NSURLComponents().tuned {
            $0.scheme = "https"
            $0.host = "unsplash.com"
            $0.path = "/oauth/token"
            $0.queryItems = [URLQueryItem(name: "grant_type", value: "authorization_code"),
                             URLQueryItem(name: "client_id", value: appId),
                             URLQueryItem(name: "client_secret", value: secret),
                             URLQueryItem(name: "redirect_uri", value: "urn:ietf:wg:oauth:2.0:oob"),
                             URLQueryItem(name: "code", value: code)]
        }
        return components.url
    }
    
    // MARK: Init
    
    init(appId: String, secret: String, scopes: [String] = AuthManager.publicScope) {
        self.appId = appId
        self.secret = secret
        self.redirectURL = URL(string: "unsplash-" + self.appId + "://token")!
        self.scopes = scopes
    }
    
    // MARK: Interface
    
    func auth(from controller: UIViewController, completion: @escaping TokenCompletion) {
        guard let url = authUrl else { completion(nil, nil); return }
        
        AuthViewController(startUrl: url, dismissUrl: redirectURL).tuned {
            $0.dismissCompletion = { didCancel in
                guard didCancel else { return }
                completion(nil, AuthError.error(code: .userCanceledAuth, description: ""))
            }
            
            $0.urlMatchCompletion = { [weak self] url in
                self?.fetchToken(from: url, completion: completion)
            }
            
            let navVc = NavigationController(rootViewController: $0)
            navVc.modalPresentationStyle = .overFullScreen
            controller.present(navVc, animated: true, completion: nil)
        }
    }
    
    func clearAccessToken() -> Bool {
        return Keychain.clear()
    }
    
    // MARK: Implementation
    
    private func fetchToken(from url: URL, completion: @escaping TokenCompletion) {
        let (extractCode, error) = extract(url: url)
        
        if let error = error {
            completion(nil, error)
            return
        }
        
        guard let code = extractCode, let tokenUrl = accessTokenUrl(code: code) else {
            completion(nil, nil)
            return
        }
        
        Network.request(tokenUrl, .post) {
            switch $0 {
            case .success(let json): print(json)
            case .failure(let error): completion(nil, error as NSError)
            }
        }
        
//        let token = UnsplashAccessToken(appId: self.appId, accessToken: value["access_token"]! as! String)
//        Keychain.set(self.appId, value: token.accessToken)
//        completion(token, nil)
    }
    
    private func extract(url: URL) -> (String?, NSError?) {
        let pairs = url.queryParameters
        
        if let error = pairs["error"], let desc = pairs["error_description"] {
            return (nil, AuthError.error(codeString: error, description: desc))
        }
        
        if let code = pairs["code"] {
            return (code, nil)
        }
        
        return (nil, nil)
    }
    
    private func extractErrorFromData(data: Data) -> NSError? {
        guard
            let json = try? JSONSerialization.jsonObject(with: data) as? Json,
            let code = json?["error"] as? String,
            let desc = json?["error_description"] as? String else { return nil }
        return AuthError.error(codeString: code, description: desc)
    }
}
