import UIKit

// MARK: SplashViewController

final class SplashViewController: ViewController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: Configuration
    
    private func configure() {
        UIImageView().addTo(view).tuned {
            $0.cx(view).cy(view)
            $0.width(Screen.bounds.width).height(Screen.bounds.height)
            $0.configureFill()
            $0.image = Image.splash
        }
    }
}
