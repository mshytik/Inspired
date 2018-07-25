import UIKit

// MARK: NavigationController

class NavigationController: UINavigationController {
    
    // MARK: Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Static
    
    static func applyDefaultAppearance() {
        UINavigationBar.appearance().tuned {
            $0.tintColor = .white
            $0.barTintColor = Color.navBg
            $0.titleTextAttributes = [.foregroundColor: UIColor.white, .font: Font.navTitle]
        }
        
        UIBarButtonItem.appearance().tuned {
            $0.setTitleTextAttributes([.foregroundColor: UIColor.white.withAlphaComponent(0.6), .font: Font.barButton], for: .normal)
            $0.setTitleTextAttributes([.foregroundColor: UIColor.white.withAlphaComponent(0.3), .font: Font.barButton], for: .highlighted)
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

