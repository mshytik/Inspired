import UIKit

final class FeedViewController: ViewController {
    
}

// MARK: FeedCollectionAdapter

//final class FeedCollectionAdapter: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    // MARK: Properties
//    
//    private let collectionView: UICollectionView
//
//    private var photos: [Photo] = [] {
//        didSet { collectionView.reloadData() }
//    }
//
//    // MARK: Init
//
//    init(collectionView: UICollectionView) {
//        self.collectionView = collectionView.tuned {
//            $0.register
//        }
//    }
//
//    // MARK: UICollectionViewDataSource
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return photos.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//}
