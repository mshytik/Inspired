import UIKit

// MARK: Image

enum Image {
    static var splash: UIImage { return #imageLiteral(resourceName: "splash1.jpeg") }
    static var downloadPhoto: UIImage { return #imageLiteral(resourceName: "download.png") }
    static var like: UIImage { return #imageLiteral(resourceName: "like.png") }
    static var chart: UIImage { return #imageLiteral(resourceName: "chart.png") }
}

// MARK: Color

enum Color {
    static let darkOverlay = UIColor.black.withAlphaComponent(0.7)
    static let navBg = rgb(35, 39, 24)
    static let feedBg = rgb(55, 59, 44)
}

// MARK: Font

enum Font {
    static let bigTitle = basic(55)
    static let navTitle = basic(21)
    static let borderButton = basic(21)
    static let photoAuthor = italic(14)
    static let barButton = basic(17)
    static let chartAxis = basic(10)
    
    static func basic(_ size: CGFloat) -> UIFont { return UIFont(name: "AvenirNext-Regular", size: size)! }
    static func italic(_ size: CGFloat) -> UIFont { return UIFont(name: "AvenirNext-Italic", size: size)! }
}

// MARK: Time

enum Time {
    static let splashDelay = 0.25
}

// MARK: Format

enum Format {
    static func prettyPublishDate(_ input: String) -> String {
        guard let date = publishInputDf.date(from: input) else { return Text.empty }
        return publishOutDf.string(from: date)
    }
    
    private static let publishOutDf: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, HH:mm"
        return formatter
    }()
    
    private static let publishInputDf: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
}

// MARK: Text

enum Text {
    static let appTitle = "Inspiration"
    
    static let empty = ""
    static let space = " "
    
    enum Common {
        static let cancel = "Cancel"
        static let initNA = "init(coder:) has not been implemented"
    }
    
    enum Auth {
        static let view = "Inspire Me!"
        static let auth = "Login with Unsplash"
        static let title = "Unsplash"
    }
    
    enum Details {
        static let title = "Photo Stats"
    }
}
