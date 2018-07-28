import UIKit
import WebKit

// MARK: UIColor

extension UIColor {
    func alpha(_ value: CGFloat) -> UIColor {
        return withAlphaComponent(value)
    }
}

// MARK: UIImage

extension UIImage {
    static func make(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let output = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return output
    }
    
    var template: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }
}

// MARK: UIView

extension UIView {
    @discardableResult func addTo(_ parent: UIView) -> Self {
        parent.addSubview(self)
        return self
    }
    
    var toOpaque: Animation { return { self.alpha = Alpha.opaque } }
    var toClear: Animation { return { self.alpha = Alpha.clear } }
    
    @discardableResult func toVisible(_ visible: Bool) -> Self {
        alpha = Alpha.isVisible(visible)
        return self
    }
}

extension Array where Element == UIView {
    var toOpaque: Animation { return { self.forEach { $0.toOpaque() } } }
    var toClear: Animation { return { self.forEach { $0.toClear() } } }
}

// MARK: UILabel

extension UILabel {
    @discardableResult func update(_ font: UIFont,
                                   _ color: UIColor,
                                   _ alignment: NSTextAlignment = .left) -> Self {
        self.font = font
        self.textColor = color
        self.textAlignment = alignment
        return self
    }
    
    @discardableResult func configureMultiline() -> Self {
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        return self
    }
}

// MARK: UIImageView

extension UIImageView {
    @discardableResult func configureFill() -> Self {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        return self
    }
}

// MARK: UIButton

extension UIButton {
    @discardableResult func configureBordered() -> Self {
        width(GUI.width).height(GUI.height)
        layer.cornerRadius = GUI.corner
        layer.borderWidth = GUI.border
        layer.borderColor = GUI.color.cgColor
        setTitleColor(GUI.color, for: .normal)
        setTitleColor(GUI.color.withAlphaComponent(Alpha.highlighted), for: .highlighted)
        titleLabel?.font = Font.borderButton
        return self
    }
    
    @discardableResult func configureBarItem() -> Self {
        width(GUI.barWidth).height(GUI.barHeight)
        titleLabel?.font = Font.barButton
        setTitleColor(.white, for: .normal)
        return self
    }
    
    private enum GUI {
        static let width: CGFloat = 300
        static let height: CGFloat = 50
        static let corner: CGFloat = height / 2
        static let border: CGFloat = 2
        
        static let barWidth: CGFloat = 64
        static let barHeight: CGFloat = 44
        
        static let color = Color.primary
    }
}

// MARK: UICollectionView

extension UICollectionView {
    static func vertical() -> UICollectionView {
        let layout = UICollectionViewFlowLayout().tuned {
            $0.scrollDirection = .vertical
            $0.minimumInteritemSpacing = NumConst.attached
            $0.minimumLineSpacing = NumConst.attached
            $0.headerReferenceSize = .zero
            $0.footerReferenceSize = .zero
            $0.sectionInset = .zero
        }
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout).tuned {
            $0.backgroundColor = .clear
        }
    }
    
    @discardableResult func register<T: UICollectionViewCell>(_ type: T.Type) -> Self {
        register(T.self, forCellWithReuseIdentifier: String(describing: type))
        return self
    }
    
    func dequeue<T: UICollectionViewCell>(_ path: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: path) as! T
    }
    
    @discardableResult func configureSource(_ source: CollectionSource) -> Self {
        dataSource = source
        delegate = source
        return self
    }
}

// MARK: UIViewController

extension UIViewController {
    func presentInNavStack(_ vc: UIViewController) {
        let navVc = NavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .overFullScreen
        present(navVc, animated: true)
    }
}

// MARK: WKWebView

extension WKWebView {
    func loadIfStackEmpty(_ url: URL) {
        guard !canGoBack else { return }
        load(URLRequest(url: url))
    }
}
