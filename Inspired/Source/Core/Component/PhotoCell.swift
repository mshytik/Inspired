import UIKit
import Nuke

// MARK: PhotoCell

final class PhotoCell: UICollectionViewCell {
    
    // MARK: Properties
    
    private let photoImageView = UIImageView()
    private let titleLabel = UILabel()
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
        
        titleLabel.addTo(contentView).tuned {
            $0.bottom(photoImageView, -8).left(photoImageView, 16)
            $0.textColor = .white
            $0.font = Font.photoAuthor
            $0.textAlignment = .left
        }
        
        UIButton(type: .custom).addTo(contentView).tuned {
            $0.cy(titleLabel, -8).right(photoImageView, -16).width(35).height(35)
            $0.setImage(Image.downloadPhoto.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.tintColor = UIColor.white.withAlphaComponent(0.65)
        }
        
        UIImageView().addTo(contentView).tuned {
            $0.top(photoImageView, 16).right(photoImageView, -16).width(35).height(35)
            $0.image = Image.like.withRenderingMode(.alwaysTemplate)
            $0.tintColor = UIColor.white.withAlphaComponent(0.65)
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
        titleLabel.text = photo.name
        guard let url = URL(string: photo.regularUrl) else { return }
        heightPin?.constant = photo.heightForFullWidth
        Nuke.loadImage(with: url, into: photoImageView)
    }
}
