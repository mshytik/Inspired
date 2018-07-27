import UIKit

// MARK: NavigationController

class NavigationController: UINavigationController {
    
    // MARK: Static
    
    static func applyDefaultAppearance() {
        UINavigationBar.appearance().tuned {
            $0.tintColor = .white
            $0.barStyle = .black
            $0.isTranslucent = false
            $0.barTintColor = Color.navBg
            $0.titleTextAttributes = [.foregroundColor: UIColor.white, .font: Font.navTitle]
        }
    }
    
    // MARK: Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.feedBg
    }
}

