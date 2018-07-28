import UIKit

// MARK: NavigationController

class NavigationController: UINavigationController {
    
    // MARK: Static
    
    static func applyDefaultAppearance() {
        UINavigationBar.appearance().tuned {
            $0.tintColor = .white
            $0.shadowImage = UIImage()
            $0.setBackgroundImage(UIImage.make(color: Color.Bg.navBar), for: .default)
            $0.titleTextAttributes = [.foregroundColor: UIColor.white, .font: Font.navTitle]
        }
    }
    
    // MARK: Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: Configure
    
    private func configure() {
        view.backgroundColor = Color.Bg.screen
        navigationBar.barTintColor = Color.Bg.navBar
    }
}

