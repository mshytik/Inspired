import UIKit

// MARK: LandingViewController

final class LandingViewController: ViewController {
    
    // MARK: Properties
    
    private let bgImageView = UIImageView(image: Image.splash)
    private let coverView = UIView()
    private let titleLabel = UILabel()
    private let loginButton = UIButton(type: .custom)
    private let viewButton = UIButton(type: .custom)
    private var titleCyPin: LayoutPin?
    
    private var fadeViews: [UIView] {
        return [coverView, titleLabel, loginButton, viewButton]
    }
    
    private var bgViews: [UIView] {
        return [view, bgImageView, coverView]
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        initialAnimation()
    }
    
    // MARK: Animate
    
    private func initialAnimation() {
        after(GUI.initialDelay) {
            UIView.animate(withDuration: GUI.darkDuration,
                           animations: { self.coverView.toOpaque() },
                           completion: { _ in self.animateTitle() })
        }
    }
    
    private func animateTitle() {
        titleCyPin?.constant = GUI.destinationTitleY
        UIView.animate(withDuration: GUI.titleDuration) {
            self.view.layoutIfNeeded()
            self.fadeViews.forEach { $0.toOpaque() }
        }
    }
    
    private func animateToHome() {
        let animation: Animation = { self.fadeViews.forEach { $0.toClear() } }
        UIView.animate(withDuration: GUI.outDuration, animations: animation) { _ in
            UIView.animate(withDuration: GUI.outDuration,
                           animations: { self.bgViews.forEach { $0.toClear() } },
                           completion: { _ in self.toFeed() })
        }
    }
    
    // MARK: Actions
    
    @objc func authTap() {
        AuthManager.shared.auth(from: self) { _, _ in }
    }
    
    @objc func viewTap() {
        animateToHome()
    }
    
    private func toFeed() {
        FeedViewController().tuned {
            let navVc = NavigationController(rootViewController: $0)
            navVc.view.toClear()
            appWindow?.rootViewController = navVc
            UIView.animate(withDuration: GUI.navFadeDuration, animations: { navVc.view.toOpaque() })
        }
    }
    
    // MARK: Configure
    
    private func configure() {
        fadeViews.forEach { $0.alpha = Alpha.clear }
        
        let root = UIView().addTo(view).tuned {
            $0.top(view).left(view).width(Screen.bounds.width).height(Screen.bounds.height)
        }
        
        bgImageView.addTo(root).fillParent().configureFill()
        
        coverView.addTo(root).fillParent().tuned {
            $0.backgroundColor = Color.darkOverlay
        }
        
        titleLabel.addTo(root).cx(root).tuned {
            titleCyPin = $0.pinCy(root, GUI.initialTitleY)
            $0.update(Font.bigTitle, .white)
            $0.text = Text.appTitle.capitalized
        }
        
        viewButton.addTo(root).tuned {
            $0.configureBordered()
            $0.bottom(root, -GUI.buttonOffset).cx(root)
            $0.setTitle(Text.Auth.view, for: .normal)
            $0.addTarget(self, action: #selector(viewTap), for: .touchUpInside)
        }
        
        loginButton.addTo(root).tuned {
            $0.above(viewButton, -GUI.buttonSpace).cx(root)
            $0.configureBordered()
            $0.setTitle(Text.Auth.auth, for: .normal)
            $0.addTarget(self, action: #selector(authTap), for: .touchUpInside)
        }
    }
    
    // MARK: GUI
    
    private enum GUI {
        static let initialDelay: TimeInterval = 0.3
        static let darkDuration: TimeInterval = 0.55
        static let titleDuration: TimeInterval = 0.5
        static let outDuration: TimeInterval = 0.8
        static let navFadeDuration: TimeInterval = 0.35
        
        static let initialTitleY: CGFloat = -60
        static let destinationTitleY = NumConst.attached
        static let buttonOffset: CGFloat = 50
        static let buttonSpace = buttonOffset / 2
    }
}
