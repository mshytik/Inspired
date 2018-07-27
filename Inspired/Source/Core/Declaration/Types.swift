import UIKit
import WebKit

// MARK: Data

typealias Json = [String: Any]
typealias Args = [UIApplicationLaunchOptionsKey: Any]

enum Result<Value> {
    case success(value: Value)
    case failure(error: Error)
    
    var value: Value? {
        switch self {
        case .success(let value): return value
        case .failure: return nil
        }
    }
    
    var error: Error? {
        switch self {
        case .success: return nil
        case .failure(let error): return error
        }
    }
}

// MARK: Ui

typealias LayoutPin = NSLayoutConstraint

// MARK: Closure

typealias Execution = () -> ()
typealias Animation = Execution
typealias OnComplete = (Bool) -> Void
typealias PolicyComplete = (WKNavigationActionPolicy) -> Void

// MARK: Protocol

typealias CollectionSource = UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
