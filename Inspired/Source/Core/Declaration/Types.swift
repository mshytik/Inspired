import UIKit
import WebKit

// MARK: Data

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

typealias Json = [String: Any]
typealias Args = [UIApplicationLaunchOptionsKey: Any]

// MARK: Ui

typealias LayoutPin = NSLayoutConstraint
typealias CollectionSource = UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

// MARK: Closure

typealias ResultCompletion<ResultType> = (Result<ResultType>) -> Void

typealias Execution = () -> ()
typealias Animation = Execution
typealias OnComplete = (Bool) -> Void
typealias UrlCompletion = (URL) -> Void
typealias PhotoCompletion = (Photo) -> Void
typealias PhotosCompletion = ([Photo]) -> Void
typealias UrlPolicyHandler = (WKNavigationActionPolicy) -> Void
typealias UrlChallengeHandler = (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
