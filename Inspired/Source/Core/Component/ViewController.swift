import UIKit

// MARK: ViewController

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UILabel().tuned {
            view.addSubview($0)
            $0.cxy(view)
            $0.text = "test output"
            $0.textColor = .black
            $0.font = UIFont.systemFont(ofSize: 35)
        }
    }
    
}

