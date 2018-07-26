import UIKit

// MARK: SplashViewController

final class SplashViewController: ViewController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        dispatchInitialFlow()
    }
    
    // MARK: Configuration
    
    private func dispatchInitialFlow() {
        after(Time.splashDelay) { setRootScreen(LandingViewController()) }
    }
    
    private func configure() {
        UIImageView(image: Image.splash).addTo(view).fillParent().configureFill()
    }
}
