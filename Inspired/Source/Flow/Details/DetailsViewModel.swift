import UIKit

// MARK: DetailsViewModel

final class DetailsViewModel: NSObject, CollectionSource {
    
    // MARK: Types
    
    typealias DetailsCompletion = (DetailsViewModel) -> Void
    
    // MARK: Properties
    
    var fetchCompletion: DetailsCompletion?
    
    private let id: String
    private var stats: PhotoStats? { didSet { fetchCompletion?(self) } }
    private var items: [PhotoStat] { return (stats?.stats ?? []).sorted { $0.totalValue > $1.totalValue } }
    
    // MARK: Init
    
    init(id: String) {
        self.id = id
        super.init()
    }
    
    // MARK: Interface
    
    func configureCollection(_ view: UICollectionView) {
        view.register(DetailsStatCell.self).configureSource(self)
    }
    
    func fetch() {
        PhotosProvider.fetchStats(id: id) { [weak self] in
            $0.value.open { self?.stats = $0 }
            $0.error.open { self?.handle(error: $0) }
        }
    }
    
    // MARK: Implementation
    
    private func handle(error: Error) {
        print(error)
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ view: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ view: UICollectionView, cellForItemAt path: IndexPath) -> UICollectionViewCell {
        let cell: DetailsStatCell = view.dequeue(path)
        return cell.tuned { $0.statsView.configure(viewModel: StatsViewModel(stat: items[path.row])) }
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ view: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt idx: IndexPath) -> CGSize {
        return CGSize(width: Screen.width, height: StatsView.viewHeight)
    }
}
