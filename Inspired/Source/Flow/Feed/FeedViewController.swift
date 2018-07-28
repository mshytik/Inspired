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
    
    // MARK: Navigation
    
    private func toStats(photo: Photo) {
        DetailsViewController().tuned { [weak self] vc in
            vc.view.frame = Screen.bounds
            after(0.35) { self?.presentInNavStack(vc) }
        }
    }
    
    // MARK: Configuration
    
    private func configure() {
        tuned {
            $0.title = Text.Common.guestName
            $0.view.backgroundColor = Color.Bg.screen
        }
        
        collectionView.addTo(view).tuned {
            $0.top(view).left(view).width(Screen.width).height(Screen.height)
        }
        
        viewModel.tuned {
            $0.configureCollection(collectionView)
            $0.photoSelection = { [weak self] in self?.toStats(photo: $0) }
            $0.photosCompletion = { [weak self] _ in self?.collectionView.reloadData() }
        }
    }
    
    // MARK:
}
