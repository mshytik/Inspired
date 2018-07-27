import UIKit
import WebKit

// MARK: AuthViewController

final class AuthViewController: ViewController, WKNavigationDelegate {
    
    // MARK: Types
    
    typealias UrlCompletion = (URL) -> Void
    typealias NavAction = WKNavigationAction
    typealias Challenge = URLAuthenticationChallenge
    typealias ChallengeComplete = (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    
    // MARK: Properties
    
    let startUrl: URL
    let dismissUrl: URL
    
    var dismissCompletion: OnComplete?
    var urlMatchCompletion: UrlCompletion?
    
    private let webView = WKWebView()
    
    // MARK: Init
    
    init(startUrl: URL, dismissUrl: URL) {
        self.startUrl = startUrl
        self.dismissUrl = dismissUrl
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError(Text.Common.initNA) }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        webView.loadIfStackEmpty(startUrl)
    }
    
    // MARK: WKNavigationDelegate
    
    func webView(_ view: WKWebView, decidePolicyFor action: NavAction, decisionHandler: @escaping PolicyComplete) {
        guard let url = action.request.url, url.matches(dismissUrl) else { decisionHandler(.allow); return }
        urlMatchCompletion?(url)
        dismissAuth(animated: true)
        decisionHandler(.cancel)
    }
    
    func webView(_ view: WKWebView, didReceive challenge: Challenge, completionHandler: @escaping ChallengeComplete) {
        guard challenge.isTrusted else { completionHandler(.performDefaultHandling, nil); return }
        let credentials = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, credentials)
    }
    
    // MARK: Navigation
    
    @objc override func cancel() {
        dismissAuth(didCancel: true, animated: true)
    }
    
    func dismissAuth(animated: Bool) {
        dismissAuth(didCancel: false, animated: animated)
    }
    
    func dismissAuth(didCancel: Bool, animated: Bool) {
        mainThread {
            self.webView.stopLoading()
            self.dismissCompletion?(didCancel)
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: Configuration
    
    private func configure() {
        tuned {
            $0.title = Text.Auth.title
            $0.view.backgroundColor = .white
            $0.configureDismissButton()
        }
        
        webView.addTo(view).tuned {
            $0.left(view).top(view).height(Screen.bounds.height).width(Screen.bounds.width)
            $0.navigationDelegate = self
        }
    }
}
