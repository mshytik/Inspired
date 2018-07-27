import UIKit

// MARK: ViewController

class ViewController: UIViewController {
    
    // MARK: Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Navigation
    
    func configureDismissButton() {
        UIButton(type: .custom).tuned {
            $0.configureBarItem()
            $0.setTitle(Text.Common.cancel, for: .normal)
            $0.addTarget(self, action: #selector(cancel), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: $0)
        }
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
}

