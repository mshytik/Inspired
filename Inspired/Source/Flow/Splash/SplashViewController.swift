import UIKit

// MARK: SplashViewController

final class SplashViewController: ViewController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        dispatchInitialFlow()
    }
    
    // MARK: Logic
    
    private func dispatchInitialFlow() {
        after(GUI.dispatchDelay) { appWindow?.rootViewController = LandingViewController() }
    }
    
    // MARK: Configuration
    
    private func configure() {
        UIImageView().addTo(view).tuned {
            $0.cx(view).cy(view).width(Screen.bounds.width).height(Screen.bounds.height)
            $0.configureFill()
            $0.image = Image.splash
        }
    }
    
    // MARK: GUI
    
    private enum GUI {
        static let dispatchDelay = 0.25
    }
}
