import UIKit

// MARK: FeedCollectionAdapter

final class FeedCollectionAdapter: NSObject, CollectionSource {
    
    // MARK: Definitions
    
    typealias PhotoSelection = (Photo) -> Void
    
    // MARK: Properties
    
    var photoSelection: PhotoSelection?
    
    private let collectionView: UICollectionView
    private var photos: [Photo] = [] { didSet { collectionView.reloadData() } }
    
    // MARK: Init
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        super.init()
        
        collectionView.tuned {
            $0.register(FeedCell.self)
            $0.dataSource = self
            $0.delegate = self
        }
    }
    
    // MARK: Configure
    
    func configure(photos: [Photo]) {
        self.photos = photos
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ view: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ view: UICollectionView, cellForItemAt path: IndexPath) -> UICollectionViewCell {
        let cell: FeedCell = collectionView.dequeue(path)
        cell.configure(photo: photos[path.row])
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ view: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        photoSelection?(photos[indexPath.row])
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ view: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt idx: IndexPath) -> CGSize {
        return CGSize(width: Screen.bounds.width, height: photos[idx.row].heightForFullWidth + 52)
    }
}
