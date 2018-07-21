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
