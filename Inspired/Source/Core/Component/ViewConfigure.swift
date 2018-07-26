import UIKit
import WebKit

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
    @discardableResult func update(_ font: UIFont, _ color: UIColor, _ alignment: NSTextAlignment = .left) -> Self {
        self.font = font
        self.textColor = color
        self.textAlignment = alignment
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
    
    private enum GUI {
        static let width: CGFloat = 300
        static let height: CGFloat = 50
        static let corner: CGFloat = height / 2
        static let border: CGFloat = 2
        
        static let color = UIColor.white
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
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    func register<T: UICollectionViewCell>(_ type: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: type))
    }
    
    func dequeue<T: UICollectionViewCell>(_ path: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: path) as! T
    }
}

// MARK: WKWebView

extension WKWebView {
    func loadIfStackEmpty(_ url: URL) {
        guard !canGoBack else { return }
        load(URLRequest(url: url))
    }
}
