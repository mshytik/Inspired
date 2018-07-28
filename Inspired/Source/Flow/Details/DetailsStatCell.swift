import UIKit

// MARK: DetailsStatCell

final class DetailsStatCell: UICollectionViewCell {
    
    // MARK: Properties
    
    let statsView = StatsView()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        statsView.addTo(contentView).top(contentView).left(contentView).right(contentView)
    }
}
