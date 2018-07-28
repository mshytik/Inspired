import UIKit

// MARK: DetailsViewController

final class DetailsViewController: ViewController {
    
    // MARK: Properties
    
    private let collectionView = UICollectionView.vertical()
    private let viewModel: DetailsViewModel
    
    // MARK: Init
    
    init(photoId: String) {
        self.viewModel = DetailsViewModel(id: photoId)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError(Text.Common.initNA) }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.fetch()
    }
    
    // MARK: Animation
    
    private func inAnimation() {
        collectionView.reloadData()
        UIView.animate(withDuration: GUI.inDuration, animations: collectionView.toOpaque)
    }
    
    // MARK: Configuration
    
    private func configure() {
        tuned {
            $0.title = Text.Details.title
            $0.configureDismissButton()
        }
        
        collectionView.addTo(view).top(view).left(view).height(Screen.height).width(Screen.width).toClear()
        
        viewModel.tuned {
            $0.configureCollection(collectionView)
            $0.fetchCompletion = { [weak self] _ in self?.inAnimation() }
        }
    }
    
    // MARK: GUI
    
    private enum GUI {
        static let inDelay: TimeInterval = 0.85
        static let inDuration: TimeInterval = 0.35
    }
}
