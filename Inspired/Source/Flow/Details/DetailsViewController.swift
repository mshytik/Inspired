import UIKit

// MARK: DetailsViewController

final class DetailsViewController: ViewController {
    
    // MARK: Properties
    
    private let statsView = StatsView(viewModel: StatsView.defaultViewModel)
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        dispatchInAnimation()
    }
    
    // MARK: Animation
    
    private func dispatchInAnimation() {
        after(GUI.inDelay) { UIView.animate(withDuration: GUI.inDuration, animations: self.statsView.toOpaque) }
    }
    
    // MARK: Configuration
    
    private func configure() {
        tuned {
            $0.title = Text.Details.title
            $0.view.backgroundColor = Color.Bg.screen
            $0.configureDismissButton()
        }
        
        statsView.addTo(view).tuned {
            $0.top(view).left(view).toClear()
            $0.updateUi()
        }
    }
    
    // MARK: GUI
    
    private enum GUI {
        static let inDelay: TimeInterval = 0.85
        static let inDuration: TimeInterval = 0.35
    }
}
