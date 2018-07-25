import UIKit

// MARK: Image

enum Image {
    static var splash: UIImage { return #imageLiteral(resourceName: "splash1.jpeg") }
}

// MARK: Color

enum Color {
    static let darkOverlay = UIColor.black.withAlphaComponent(0.7)
}

// MARK: Font

enum Font {
    static let bigTitle = basic(55)
    static let borderButton = basic(21)
    
    static func basic(_ size: CGFloat) -> UIFont? { return UIFont(name: "Papyrus", size: size) }
}

// MARK: Text

enum Text {
    static let appTitle = "Inspiration"
    
    enum Common {
        static let cancel = "Cancel"
        static let initNA = "init(coder:) has not been implemented"
    }
    
    enum Auth {
        static let view = "Inspire Now!"
        static let auth = "Login with Unsplash"
        static let title = auth
    }
}
