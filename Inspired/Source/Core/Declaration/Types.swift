import UIKit

// MARK: Data

typealias Json = [String: Any]
typealias Args = [UIApplicationLaunchOptionsKey: Any]

// MARK: Closure

typealias Execution = () -> ()
typealias Animation = Execution
typealias OnComplete = (Bool) -> Void
