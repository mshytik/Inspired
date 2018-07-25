import UIKit
import WebKit

// MARK: Data

typealias Json = [String: Any]
typealias Args = [UIApplicationLaunchOptionsKey: Any]

enum Result<Value> {
    case success(value: Value)
    case failure(error: Error)
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
