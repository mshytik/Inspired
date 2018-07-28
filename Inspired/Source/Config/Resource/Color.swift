import UIKit

// MARK: Color

enum Color {
    
    // MARK: Common
    
    static let primary = Chart.tint
    
    // MARK: Bg
    
    enum Bg {
        static let screen = rgb(45, 42, 38)
        static let navBar = rgb(35, 32, 28).alpha(0.95)
        static let fadeDark = UIColor.black.alpha(0.7)
        static let separator = UIColor.black
    }
    
    // MARK: Chart
    
    enum Chart {
        static let tint = rgb(215, 254, 252)
        static let value = tint
        static let label = tint.alpha(0.8)
        static let border = tint.alpha(0.4)
        static let grid = tint.alpha(0.3)
        
        static let highlight = rgb(57, 224, 93)
    }
}
