import Foundation

// MARK: Tuned

protocol Tuned { }

extension NSObject: Tuned { }

extension Tuned where Self: Any {
    @discardableResult func tuned(_ execution: (Self) throws -> Void) rethrows -> Self {
        try execution(self)
        return self
    }
}

extension Tuned where Self: AnyObject {
    @discardableResult func tuned(_ execution: (Self) throws -> Void) rethrows -> Self {
        try execution(self)
        return self
    }
}
