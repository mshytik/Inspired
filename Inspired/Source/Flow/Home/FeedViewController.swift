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
            guard let this = self else { return }
            switch $0 {
            case .success(let photos): this.adapter?.configure(photos: photos)
            case .failure(let error): print(error)
            }
        }
    }
    
    // MARK: Configuration
    
    private func configure() {
        title = "Guest"
        
        view.tuned {
            $0.backgroundColor = Color.navBg.withAlphaComponent(0.65)
        }
        
        collectionView.addTo(view).tuned {
            $0.width(Screen.bounds.width).height(Screen.bounds.height).top(view).left(view)
            adapter = FeedCollectionAdapter(collectionView: $0)
            $0.backgroundColor = .white
        }
    }
    
    // MARK: GUI
    
    private enum GUI {
        
    }
}
