import UIKit

// MARK: FeedViewController

final class FeedViewController: ViewController {
    
    // MARK: Properties
    
    private let collectionView = UICollectionView.vertical()
    private let viewModel = FeedViewModel()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.fetchPhotos()
    }
    
    // MARK: Implementation
    
    private func toStats(photo: Photo) {
        DetailsViewController(photoId: photo.id).tuned { [weak self] vc in
            _ = vc.view.frame
            after(GUI.statsPresentDelay) { self?.presentInNavStack(vc) }
        }
    }
    
    // MARK: Configure
    
    private func configure() {
        title = Text.Common.guestName
        
        collectionView.addTo(view).top(view).left(view).height(Screen.height).width(Screen.width).right(view)
        
        viewModel.tuned {
            $0.configureCollection(collectionView)
            $0.photoSelection = { [weak self] in self?.toStats(photo: $0) }
            $0.photosCompletion = { [weak self] _ in self?.collectionView.reloadData() }
        }
    }
    
    // MARK: GUI
    
    private enum GUI {
        static let statsPresentDelay: TimeInterval = 0.35
    }
}
