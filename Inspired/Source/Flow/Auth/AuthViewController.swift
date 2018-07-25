import UIKit
import WebKit

// MARK: AuthViewController

final class AuthViewController: ViewController, WKNavigationDelegate {
    
    // MARK: Types
    
    typealias UrlCompletion = (URL) -> Void
    
    // MARK: Properties
    
    let startUrl: URL
    let dismissUrl: URL
    
    var dismissCompletion: OnComplete?
    var urlMatchCompletion: UrlCompletion?
    
    private let webView = WKWebView()
    private let cancelButton = UIBarButtonItem(title: Text.Common.cancel,
                                               style: .plain,
                                               target: self,
                                               action: #selector(cancel))
    
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
        if !webView.canGoBack { load(url: startUrl) }
    }
    
    // MARK: Logic (url handling)
    
    private func load(url: URL) {
        webView.load(URLRequest(url: url))
    }
    
    private func matchesDismissUrl(_ url: URL) -> Bool {
        return url.scheme == dismissUrl.scheme && url.host == dismissUrl.host && url.path == dismissUrl.path
    }
    
    // MARK: WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
    
    private func webView(webView: WKWebView,
                 decidePolicyForNavigationAction action: WKNavigationAction,
                 decisionHandler: PolicyComplete) {
        guard let url = action.request.url, matchesDismissUrl(url) else { decisionHandler(.allow); return }
        urlMatchCompletion?(url)
        dismissAuth(animated: true)
        decisionHandler(.cancel)
    }
    
    func webView(_ webView: WKWebView,
                 didReceive challenge: URLAuthenticationChallenge,
                 completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard challenge.isTrusted else { completionHandler(.performDefaultHandling, nil); return }
        let credentials = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, credentials)
    }
    
    // MARK: Navigation
    
    @objc func cancel() {
        dismissAuth(didCancel: true, animated: true)
    }
    
    func dismissAuth(animated: Bool) {
        dismissAuth(didCancel: false, animated: animated)
    }
    
    func dismissAuth(didCancel: Bool, animated: Bool) {
        webView.stopLoading()
        dismissCompletion?(didCancel)
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Configuration
    
    private func configure() {
        tuned {
            $0.title = Text.Auth.title
            $0.view.backgroundColor = .white
            $0.navigationItem.rightBarButtonItem = cancelButton

            guard let frame = cancelButton.customView?.frame else { return }
            let destFrame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
            cancelButton.customView?.frame = destFrame
        }
        
        webView.addTo(view).tuned {
            $0.left(view).top(view).height(Screen.bounds.height).width(Screen.bounds.width)
            $0.navigationDelegate = self
        }
    }
}
