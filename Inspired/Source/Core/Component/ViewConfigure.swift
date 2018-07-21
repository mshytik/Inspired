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
        static let width: CGFloat = 250
        static let height: CGFloat = 50
        static let corner: CGFloat = height / 2
        static let border: CGFloat = 2
        
        static let color = UIColor.white
    }
}
