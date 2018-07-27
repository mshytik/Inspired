import UIKit
import Nuke

// MARK: PhotoCell

final class FeedCell: UICollectionViewCell {
    
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
        
        let root = UIView().addTo(contentView).tuned {
            $0.left(contentView).top(contentView).width(Screen.bounds.width)
            heightPin = $0.pinHeight(GUI.defaultRootHeight)
        }
        
        photoImageView.addTo(root).tuned {
            $0.fillParent().configureFill()
        }
        
        UIView().addTo(root).tuned {
            $0.bottom(root).left(root).width(Screen.bounds.width).height(0.5)
            $0.backgroundColor = .black
        }
        
        let bottomRoot = UIView().addTo(contentView).tuned {
            $0.under(root).left(root).right(root).height(52)
            $0.backgroundColor = Color.navBg
        }
        
        titleLabel.addTo(bottomRoot).tuned {
            $0.left(bottomRoot, 16).cy(bottomRoot).update(Font.photoAuthor, .white)
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
        }
        
        let loadButton = UIButton(type: .custom).addTo(bottomRoot).tuned {
            $0.cy(titleLabel).right(bottomRoot, -16).width(25).height(25)
            $0.setImage(Image.downloadPhoto.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.tintColor = UIColor.white.withAlphaComponent(0.65)
        }
        
        let chartImage = UIImageView().addTo(bottomRoot).tuned {
            $0.cy(titleLabel, -1).before(loadButton, -24).width(25).height(25)
            $0.image = Image.chart.withRenderingMode(.alwaysTemplate)
            $0.tintColor = UIColor.white.withAlphaComponent(0.65)
        }
        
        UIImageView().addTo(bottomRoot).tuned {
            $0.cy(titleLabel, -2).before(chartImage, -24).width(25).height(25)
            $0.image = Image.like.withRenderingMode(.alwaysTemplate)
            $0.tintColor = UIColor.white.withAlphaComponent(0.65)
        }
    }
    
    // MARK: Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clearImage()
    }
    
    // MARK: Configuration
    
    func configure(photo: Photo) {
        titleLabel.text = "by " + photo.name + "\non " + Format.prettyPublishDate(photo.date)
        heightPin?.constant = photo.heightForFullWidth
        configure(imageUrlString: photo.smallUrl)
    }
    
    private func configure(imageUrlString: String) {
        guard let url = URL(string: imageUrlString) else { clearImage(); return }
        Nuke.loadImage(with: url, options: GUI.imageOptions, into: photoImageView)
    }
    
    private func clearImage() {
        Nuke.cancelRequest(for: photoImageView)
        photoImageView.image = nil
    }
    
    // MARK: GUI
    
    private enum GUI {
        static let defaultRootHeight: CGFloat = 300
        
        static var imageOptions: ImageLoadingOptions {
            return ImageLoadingOptions(transition: ImageLoadingOptions.Transition.fadeIn(duration: 0.3))
        }
    }
}
