import UIKit

// MARK: ViewController

class ViewController: UIViewController {
    
    // MARK: Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: Interface
    
    func configureDismissButton() {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        UIButton(type: .custom).tuned {
            $0.configureBarItem()
            $0.setImage(Image.close.template, for: .normal)
            $0.addTarget(self, action: #selector(cancel), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: $0)
        }
    }
    
    // MARK: Implementation
    
    private func configure() {
        view.backgroundColor = Color.Bg.screen
    }
    
    @objc func cancel() {
        dismiss(animated: true)
    }
}

