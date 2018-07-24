import UIKit
import Nuke

// MARK: PhotoCell

final class PhotoCell: UICollectionViewCell {
    
    // MARK: Properties
    
    private let photoImageView = UIImageView()
    private var heightPin: LayoutPin?
    
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
        contentView.clipsToBounds = true
        
        photoImageView.addTo(contentView).tuned {
            $0.width(Screen.bounds.width).top(contentView).left(contentView)
            heightPin = $0.pinHeight(NumConst.attached)
            $0.configureFill()
        }
        
        UIView().addTo(contentView).tuned {
            $0.width(Screen.bounds.width).height(3).top(contentView).left(contentView)
            $0.backgroundColor = .black
        }
        
        UIView().addTo(contentView).tuned {
            $0.width(Screen.bounds.width).top(contentView).left(contentView).bottom(photoImageView)
            $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
    }
    
    // MARK: Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        Nuke.cancelRequest(for: photoImageView)
        photoImageView.image = nil
    }
    
    // MARK: Configuration
    
    func configure(photo: Photo) {
        guard let url = URL(string: photo.regularUrl) else { return }
        heightPin?.constant = photo.heightForFullWidth
        Nuke.loadImage(with: url, into: photoImageView)
    }
}
