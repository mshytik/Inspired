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
        UIImageView(image: Image.splash).addTo(view).fillParent().configureFill()
    }
    
    // MARK: GUI
    
    private enum GUI {
        static let dispatchDelay = 0.25
    }
}
