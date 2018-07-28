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
            $0.left(contentView).top(contentView).width(Screen.width)
            heightPin = $0.pinHeight(GUI.defaultRootHeight)
        }
        
        photoImageView.addTo(root).fillParent().configureFill()
        
        UIView().addTo(root).tuned {
            $0.bottom(root).left(root).width(Screen.width).height(Layout.separatorH)
            $0.backgroundColor = Color.Bg.separator
        }
        
        let bottomRoot = UIView().addTo(contentView).tuned {
            $0.under(root).left(root).right(root).height(FeedCellViewModel.barHeight)
            $0.backgroundColor = Color.Bg.navBar
        }
        
        titleLabel.addTo(bottomRoot).tuned {
            $0.left(bottomRoot, Layout.margin).cy(bottomRoot)
            $0.configureMultiline()
            $0.update(Font.photoAuthor, Color.primary)
        }
        
        let loadButton = UIButton(type: .custom).addTo(bottomRoot).tuned {
            $0.cy(titleLabel).right(bottomRoot, -Layout.margin).square(GUI.iconSide)
            $0.setImage(Image.downloadPhoto.template, for: .normal)
            $0.tintColor = GUI.iconColor
        }
        
        let chartImage = UIImageView().addTo(bottomRoot).tuned {
            $0.cy(titleLabel, GUI.chartDy).before(loadButton, GUI.iconDx).square(GUI.iconSide)
            $0.image = Image.chart.template
            $0.tintColor = GUI.iconColor
        }
        
        UIImageView().addTo(bottomRoot).tuned {
            $0.cy(titleLabel, GUI.likeDy).before(chartImage, GUI.iconDx).square(GUI.iconSide)
            $0.image = Image.like.template
            $0.tintColor = GUI.iconColor
        }
    }
    
    // MARK: Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clearImage()
    }
    
    // MARK: Configuration
    
    func configure(viewModel: FeedCellViewModel) {
        titleLabel.text = viewModel.title
        heightPin?.constant = viewModel.fullWidthPhotoHeight
        configure(imageUrlString: viewModel.photoUrlString)
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
        static let iconSide: CGFloat = 25
        static let iconDx: CGFloat = -24
        static let chartDy: CGFloat = -1
        static let likeDy: CGFloat = -2
        static let iconColor = Color.primary.withAlphaComponent(0.75)
        
        static var imageOptions: ImageLoadingOptions {
            return ImageLoadingOptions(transition: ImageLoadingOptions.Transition.fadeIn(duration: 0.3))
        }
    }
}
