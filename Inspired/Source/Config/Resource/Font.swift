import UIKit

// MARK: Font

enum Font {
    
    // MARK: Accessor
    
    static let bigTitle = basic(55)
    static let navTitle = basic(21)
    static let borderButton = basic(21)
    static let photoAuthor = italic(14)
    static let statBar = italic(13)
    static let barButton = basic(17)
    static let chartAxis = basic(11)
    
    private enum Name {
        static let regular = "AvenirNext-Regular"
        static let italic = "AvenirNext-Italic"
    }
    
    // MARK: Helper
    
    private static func basic(_ size: CGFloat) -> UIFont {
        return UIFont(name: Name.regular, size: size)!
    }
    
    private static func italic(_ size: CGFloat) -> UIFont {
        return UIFont(name: Name.italic, size: size)!
    }
}
