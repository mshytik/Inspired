import UIKit

// MARK: Layout

private let zr = NumConst.attached

extension UIView {
    
    // MARK: Types
    
    typealias Pin = LayoutPin
    
    // MARK: Interface
    
    @discardableResult func top(_ to: UIView, _ d: CGFloat = zr) -> Self { pinTop(to, d); return self }
    @discardableResult func pinTop(_ to: UIView, _ d: CGFloat = zr) -> Pin? { return pin(.top, to, .top, d) }
    
    @discardableResult func bottom(_ to: UIView, _ d: CGFloat = zr) -> Self { pinBottom(to, d); return self }
    @discardableResult func pinBottom(_ to: UIView, _ d: CGFloat = zr) -> Pin? { return pin(.bottom, to, .bottom, d) }
    
    @discardableResult func left(_ to: UIView, _ d: CGFloat = zr) -> Self { pinLeft(to, d); return self }
    @discardableResult func pinLeft(_ to: UIView, _ d: CGFloat = zr) -> Pin? { return pin(.leading, to, .leading, d) }
    
    @discardableResult func right(_ to: UIView, _ d: CGFloat = zr) -> Self { pinRight(to, d); return self }
    @discardableResult func pinRight(_ to: UIView, _ d: CGFloat = zr) -> Pin? { return pin(.trailing, to, .trailing, d) }
    
    @discardableResult func above(_ to: UIView, _ d: CGFloat = zr) -> Self { pinAbove(to, d); return self }
    @discardableResult func pinAbove(_ to: UIView, _ d: CGFloat = zr) -> Pin? { return pin(.bottom, to, .top, d) }
    
    @discardableResult func under(_ to: UIView, _ d: CGFloat = zr) -> Self { pinUnder(to, d); return self }
    @discardableResult func pinUnder(_ to: UIView, _ d: CGFloat = zr) -> Pin? { return pin(.top, to, .bottom, d) }
    
    @discardableResult func next(_ to: UIView, _ d: CGFloat = zr) -> Self { pinNext(to, d); return self }
    @discardableResult func pinNext(_ to: UIView, _ d: CGFloat = zr) -> Pin? { return pin(.left, to, .right, d) }
    
    @discardableResult func before(_ to: UIView, _ d: CGFloat = zr) -> Self { pinBefore(to, d); return self }
    @discardableResult func pinBefore(_ to: UIView, _ d: CGFloat = zr) -> Pin? { return pin(.right, to, .left, d) }
    
    @discardableResult func cx(_ to: UIView, _ d: CGFloat = zr) -> Self { pinCx(to, d); return self }
    @discardableResult func pinCx(_ to: UIView, _ d: CGFloat = zr) -> Pin? { return pin(.centerX, to, .centerX, d) }
    
    @discardableResult func cy(_ to: UIView, _ d: CGFloat = zr) -> Self { pinCy(to, d); return self }
    @discardableResult func pinCy(_ to: UIView, _ d: CGFloat = zr) -> Pin? { return pin(.centerY, to, .centerY, d) }
    
    @discardableResult func height(_ value: CGFloat) -> Self { pinHeight(value); return self }
    @discardableResult func pinHeight(_ value: CGFloat) -> Pin? { return pin(.height, nil, nil, value) }
    
    @discardableResult func width(_ value: CGFloat) -> Self { pinWidth(value); return self }
    @discardableResult func pinWidth(_ value: CGFloat) -> Pin? { return pin(.width, nil, nil, value) }
    
    @discardableResult func height(to: UIView) -> Self { pin(.height, to, .height, zr); return self }
    
    @discardableResult func fillParent() -> Self { superview.open { top($0).bottom($0).left($0).right($0) }; return self }
    @discardableResult func cxy(_ toView: UIView) -> Self { return cx(toView).cy(toView) }
    @discardableResult func square(_ value: CGFloat) -> Self { return width(value).height(value) }
    @discardableResult func sides(_ to: UIView, _ v: CGFloat = zr) -> Self { return left(to, v).right(to, -v) }
    
    // MARK: Core
    
    @discardableResult private func pin(_ fromEdge: NSLayoutAttribute,
                                        _ toView: UIView? = nil,
                                        _ toEdge: NSLayoutAttribute? = nil,
                                        _ offset: CGFloat = NumConst.attached,
                                        _ multiplier: CGFloat = NumConst.same) -> Pin? {
        translatesAutoresizingMaskIntoConstraints = false
        toView?.translatesAutoresizingMaskIntoConstraints = false
        return Pin(item: self,
                   attribute: fromEdge,
                   relatedBy: .equal,
                   toItem: toView,
                   attribute: toEdge ?? fromEdge,
                   multiplier: multiplier,
                   constant: offset).tuned { $0.isActive = true }
    }
}
