import UIKit

extension UIView {
    @discardableResult func addTo(_ parent: UIView) -> Self {
        parent.addSubview(self)
        return self
    }
}

extension UIImageView {
    @discardableResult func configureFill() -> Self {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        return self
    }
}

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

extension UICollectionView {
    static func vertical() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = NumConst.attached
        layout.minimumLineSpacing = NumConst.attached
        layout.headerReferenceSize = .zero;
        layout.footerReferenceSize = .zero;
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    func register<T: UICollectionViewCell>(_ type: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: type))
    }
    
    func dequeue<T: UICollectionViewCell>(_ path: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: path) as! T
    }
}
