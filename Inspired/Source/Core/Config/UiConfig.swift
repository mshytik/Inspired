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
    static let bigTitle = UIFont(name: "Papyrus", size: 55)
    static let borderButton = UIFont(name: "Papyrus", size: 21)
}

// MARK: Text

enum Text {
    
    static let appTitle = "Inspiration"
    
    enum Auth {
        static let view = "View pictures"
        static let auth = "Login with Unsplash"
    }
}
