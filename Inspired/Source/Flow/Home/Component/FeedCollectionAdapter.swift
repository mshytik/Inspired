import UIKit

// MARK: FeedCollectionAdapter

final class FeedCollectionAdapter: NSObject, CollectionSource {
    
    // MARK: Properties
    
    private let collectionView: UICollectionView
    private var photos: [Photo] = [] { didSet { collectionView.reloadData() } }
    
    // MARK: Init
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        super.init()
        
        collectionView.tuned {
            $0.register(PhotoCell.self)
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
        let cell: PhotoCell = collectionView.dequeue(path)
        cell.configure(photo: photos[path.row])
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ view: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt path: IndexPath) -> CGSize {
        let photo = photos[path.row]
        return CGSize(width: Screen.bounds.width, height: photo.heightForFullWidth)
    }
}
