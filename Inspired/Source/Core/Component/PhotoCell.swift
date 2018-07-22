import UIKit

// MARK: PhotoCell

final class PhotoCell: UICollectionViewCell {
    
    // MARK: Properties
    
    private let photoImageView = UIImageView()
    
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
        
    }
}
