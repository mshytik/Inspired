import UIKit

// MARK: AuthViewController

final class AuthViewController: ViewController {
    
    // MARK: Properties
    
    private let bgImageView = UIImageView()
    private let coverView = UIView()
    private let titleLabel = UILabel()
    private let loginButton = UIButton(type: .custom)
    private let viewButton = UIButton(type: .custom)
    private var titleCyPin: LayoutPin?
    
    private var fadeViews: [UIView] { return [titleLabel, loginButton, viewButton] }
    private var bgViews: [UIView] { return [view, bgImageView, coverView] }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        initialAnimation()
        
        PhotosProvider.fetchPhotos() { _ in }
    }
    
    // MARK: Animate
    
    private func initialAnimation() {
        after(GUI.initialDelay) { [weak self] in
            UIView.animate(withDuration: GUI.darkDuration,
                           animations: { self?.coverView.alpha = Alpha.opaque },
                           completion: { _ in self?.animateTitle() })
        }
    }
    
    private func animateTitle() {
        titleCyPin?.constant = GUI.destinationTitleY
        UIView.animate(withDuration: GUI.titleDuration) {
            self.view.layoutIfNeeded()
            self.fadeViews.forEach { $0.alpha = Alpha.opaque }
        }
    }
    
    private func animateToHome() {
        let animation: Animation = { self.fadeViews.forEach { $0.alpha = Alpha.clear } }
        UIView.animate(withDuration: GUI.outDuration, animations: animation) { [weak self] _ in
            guard let this = self else { return }
            let animation: Animation = { this.bgViews.forEach { $0.alpha = Alpha.clear } }
            UIView.animate(withDuration: GUI.outDuration, animations: animation) { _ in
                
            }
        }
    }
    
    // MARK: Actions
    
    @objc func viewTap() {
        animateToHome()
    }
    
    // MARK: Configure
    
    private func configure() {
        tuned {
            $0.fadeViews.forEach { $0.alpha = Alpha.clear }
        }
        
        bgImageView.addTo(view).tuned {
            $0.cx(view).cy(view).width(Screen.bounds.width).height(Screen.bounds.height)
            $0.configureFill()
            $0.image = Image.splash
        }
        
        coverView.addTo(view).tuned {
            $0.cx(view).cy(view).width(Screen.bounds.width).height(Screen.bounds.height)
            $0.backgroundColor = Color.darkOverlay
            $0.alpha = Alpha.clear
        }
        
        titleLabel.addTo(view).tuned {
            $0.cx(view)
            titleCyPin = $0.pinCy(view, GUI.initialTitleY)
            $0.text = Text.appTitle.uppercased()
            $0.font = Font.bigTitle
            $0.textColor = .white
        }
        
        viewButton.addTo(view).tuned {
            $0.configureBordered()
            $0.bottom(view, -GUI.buttonOffset).cx(view)
            $0.setTitle(Text.Auth.view, for: .normal)
            $0.addTarget(self, action: #selector(viewTap), for: .touchUpInside)
        }
        
        loginButton.addTo(view).tuned {
            $0.configureBordered()
            $0.above(viewButton, -GUI.buttonOffset / 2).cx(view)
            $0.setTitle(Text.Auth.auth, for: .normal)
        }
    }
    
    // MARK: GUI
    
    private enum GUI {
        static let initialDelay: TimeInterval = 0.3
        static let darkDuration: TimeInterval = 0.55
        static let titleDuration: TimeInterval = 0.7
        static let outDuration: TimeInterval = 0.8
        
        static let initialTitleY: CGFloat = -80
        static let destinationTitleY = NumConst.attached
        static let buttonOffset: CGFloat = 50
    }
}
