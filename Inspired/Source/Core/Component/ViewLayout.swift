import UIKit

// MARK: Layout

private let zero = NumConst.attached

extension UIView {
    
    // MARK: Interface
    
    @discardableResult
    func pinTop(_ toView: UIView, _ offset: CGFloat = zero) -> LayoutPin? { return pin(.top, toView, .top, offset) }
    @discardableResult
    func top(_ toView: UIView, _ offset: CGFloat = zero) -> Self { pinTop(toView, offset); return self }
    
    @discardableResult
    func pinBottom(_ toView: UIView, _ offset: CGFloat = zero) -> LayoutPin? { return pin(.bottom, toView, .bottom, offset) }
    @discardableResult
    func bottom(_ toView: UIView, _ offset: CGFloat = zero) -> Self { pinBottom(toView, offset); return self }
    
    @discardableResult
    func pinLeft(_ toView: UIView, _ offset: CGFloat = zero) -> LayoutPin? { return pin(.leading, toView, .leading, offset) }
    @discardableResult
    func left(_ toView: UIView, _ offset: CGFloat = zero) -> Self { pinLeft(toView, offset); return self }
    
    @discardableResult
    func pinRight(_ toView: UIView, _ offset: CGFloat = zero) -> LayoutPin? { return pin(.trailing, toView, .trailing, offset) }
    @discardableResult
    func right(_ toView: UIView, _ offset: CGFloat = zero) -> Self { pinBottom(toView, offset); return self }
    
    @discardableResult
    func pinAbove(_ toView: UIView, _ offset: CGFloat = zero) -> LayoutPin? { return pin(.bottom, toView, .top, offset) }
    @discardableResult
    func above(_ toView: UIView, _ offset: CGFloat = zero) -> Self { pinAbove(toView, offset); return self }
    
    @discardableResult
    func pinUnder(_ toView: UIView, _ offset: CGFloat = zero) -> LayoutPin? { return pin(.top, toView, .bottom, offset) }
    @discardableResult
    func under(_ toView: UIView, _ offset: CGFloat = zero) -> Self { pinUnder(toView, offset); return self }
    
    @discardableResult
    func pinNext(_ toView: UIView, _ offset: CGFloat = zero) -> LayoutPin? { return pin(.leading, toView, .trailing, offset) }
    @discardableResult
    func next(_ toView: UIView, _ offset: CGFloat = zero) -> Self { pinAbove(toView, offset); return self }
    
    @discardableResult
    func pinBefore(_ toView: UIView, _ offset: CGFloat = zero) -> LayoutPin? { return pin(.trailing, toView, .leading, offset) }
    @discardableResult
    func before(_ toView: UIView, _ offset: CGFloat = zero) -> Self { pinBefore(toView, offset); return self }
    
    @discardableResult
    func pinCx(_ toView: UIView, _ offset: CGFloat = zero) -> LayoutPin? { return pin(.centerX, toView, .centerX, offset) }
    @discardableResult
    func cx(_ toView: UIView, _ offset: CGFloat = zero) -> Self { pinCx(toView, offset); return self }
    
    @discardableResult
    func pinCy(_ toView: UIView, _ offset: CGFloat = zero) -> LayoutPin? { return pin(.centerY, toView, .centerY, offset) }
    @discardableResult
    func cy(_ toView: UIView, _ offset: CGFloat = zero) -> Self { pinCy(toView, offset); return self }
    
    @discardableResult
    func pinHeight(_ value: CGFloat) -> LayoutPin? { return pin(.height, nil, nil, value) }
    @discardableResult
    func height(_ value: CGFloat) -> Self { pinHeight(value); return self }
    
    @discardableResult
    func pinWidth(_ value: CGFloat) -> LayoutPin? { return pin(.width, nil, nil, value) }
    @discardableResult
    func width(_ value: CGFloat) -> Self { pinWidth(value); return self }
    
    @discardableResult func fillParent() -> Self { superview.open { top($0).bottom($0).left($0).right($0) }; return self }
    @discardableResult func cxy(_ toView: UIView) -> Self { return cx(toView).cy(toView) }
    
    // MARK: Core
    
    @discardableResult private func pin(_ fromEdge: NSLayoutAttribute,
                                        _ toView: UIView? = nil,
                                        _ toEdge: NSLayoutAttribute? = nil,
                                        _ offset: CGFloat = NumConst.attached,
                                        _ multiplier: CGFloat = NumConst.same) -> LayoutPin? {
        translatesAutoresizingMaskIntoConstraints = false
        toView?.translatesAutoresizingMaskIntoConstraints = false
        return LayoutPin(item: self,
                         attribute: fromEdge,
                         relatedBy: .equal,
                         toItem: toView,
                         attribute: toEdge ?? fromEdge,
                         multiplier: multiplier,
                         constant: offset).tuned { $0.isActive = true }
    }
}
