import UIKit
import WebKit

// MARK: AuthViewController

final class AuthViewController: ViewController, WKNavigationDelegate {
    
    // MARK: Properties
    
    var dismissCompletion: OnComplete?
    var urlMatchCompletion: UrlCompletion?
    
    private let startUrl: URL
    private let dismissUrl: URL
    
    private let webView = WKWebView()
    
    // MARK: Init
    
    init(startUrl: URL, dismissUrl: URL) {
        self.startUrl = startUrl
        self.dismissUrl = dismissUrl
        
        super.init(nibName: nil, bundle: nil)
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
    
    func webView(_ view: WKWebView,
                 decidePolicyFor action: WKNavigationAction,
                 decisionHandler: @escaping UrlPolicyHandler) {
        guard let url = action.request.url, url.matches(dismissUrl) else { decisionHandler(.allow); return }
        urlMatchCompletion?(url)
        dismissAuth(animated: true)
        decisionHandler(.cancel)
    }
    
    func webView(_ view: WKWebView,
                 didReceive challenge: URLAuthenticationChallenge,
                 completionHandler: @escaping UrlChallengeHandler) {
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
            self.navigationController?.dismiss(animated: true)
        }
    }
    
    // MARK: Configure
    
    private func configure() {
        tuned {
            $0.title = Text.Auth.title
            $0.configureDismissButton()
        }
        
        webView.addTo(view).tuned {
            $0.left(view).top(view).height(Screen.height).width(Screen.width)
            $0.navigationDelegate = self
        }
    }
}
