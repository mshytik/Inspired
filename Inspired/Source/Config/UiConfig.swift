import UIKit

// MARK: Image

enum Image {
    static var splash: UIImage { return #imageLiteral(resourceName: "splash1.jpeg") }
    static var downloadPhoto: UIImage { return #imageLiteral(resourceName: "download.png") }
    static var like: UIImage { return #imageLiteral(resourceName: "like.png") }
}

// MARK: Color

enum Color {
    static let darkOverlay = UIColor.black.withAlphaComponent(0.7)
    static let navBg = rgb(35, 39, 24)
}

// MARK: Font

enum Font {
    static let bigTitle = basic(55)
    static let photoAuthor = basic(29)
    static let navTitle = basic(23)
    static let borderButton = basic(21)
    static let barButton = basic(15)
    
    static func basic(_ size: CGFloat) -> UIFont { return UIFont(name: "Papyrus", size: size)! }
}

// MARK: Text

enum Text {
    static let appTitle = "Inspiration"
    static let empty = ""
    
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
