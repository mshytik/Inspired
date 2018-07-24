import Foundation

func after(_ time: TimeInterval, _ execute: @escaping Execution) {
    DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: execute)
}

func mainThread(_ execute: @escaping Execution) {
    DispatchQueue.main.async(execute: execute)
}
