import UIKit

// MARK: FeedViewModel

final class FeedViewModel: NSObject, CollectionSource {
    
    // MARK: Properties
    
    var photoSelection: PhotoCompletion?
    var photosCompletion: PhotosCompletion?
    
    // MARK: Accessors
    
    private var photos: [Photo] = [] {
        didSet { photosCompletion?(photos) }
    }
    
    private func viewModel(at index: Int) -> FeedCellViewModel {
        return FeedCellViewModel(photo: photos[index])
    }
    
    // MARK: Data
    
    func fetchPhotos() {
        PhotosProvider.fetchPhotos { [weak self] in
            $0.value.open { self?.photos = $0 }
            $0.error.open { self?.handleError($0) }
        }
    }
    
    private func handleError(_ error: Error) {
        
    }
    
    // MARK: Configure
    
    func configureCollection(_ view: UICollectionView) {
        view.tuned {
            $0.register(FeedCell.self)
            $0.dataSource = self
            $0.delegate = self
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ view: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ view: UICollectionView, cellForItemAt path: IndexPath) -> UICollectionViewCell {
        let cell: FeedCell = view.dequeue(path)
        return cell.tuned { $0.configure(viewModel: viewModel(at: path.row)) }
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ view: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        photoSelection?(photos[indexPath.row])
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ view: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt idx: IndexPath) -> CGSize {
        return viewModel(at: idx.row).fullWidthCellSize
    }
}
