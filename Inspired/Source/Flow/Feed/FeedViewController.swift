import UIKit

// MARK: FeedViewController

final class FeedViewController: ViewController {
    
    // MARK: Properties
    
    private let collectionView = UICollectionView.vertical()
    private var adapter: FeedCollectionAdapter?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchPhotos()
    }
    
    // MARK: Logic
    
    private func fetchPhotos() {
        PhotosProvider.fetchPhotos { [weak self] in
            $0.value.open { self?.adapter?.configure(photos: $0) }
            $0.error.open { self?.handleError($0) }
        }
    }
    
    private func handleError(_ error: Error) {
        
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
            $0.title = "Guest"
            $0.view.backgroundColor = Color.feedBg
        }
        
        collectionView.addTo(view).tuned {
            $0.top(view).left(view).width(Screen.width).height(Screen.height)
            $0.backgroundColor = .clear
            adapter = FeedCollectionAdapter(collectionView: $0)
            adapter?.photoSelection = { [weak self] in self?.toStats(photo: $0) }
        }
    }
}
