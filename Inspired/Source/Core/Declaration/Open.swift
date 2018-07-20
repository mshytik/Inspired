// MARK: Open

extension Optional {
    func open(_ execution: (Wrapped) -> Void) {
        if let unwrapped = self {
            execution(unwrapped)
        }
    }
}
