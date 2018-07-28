// MARK: Char

enum Char {
    static let empty = ""
    static let space = " "
    static let eol = "\n"
    static let colon = ":"
    
    static let means = colon + space
}

// MARK: Text

enum Text {
    enum Common {
        static let cancel = "Cancel"
        static let initNA = "init(coder:) has not been implemented"
        static let guestName = "Guest"
    }
    
    enum Auth {
        static let appTitle = "Inspiration"
        static let view = "Inspire Me!"
        static let auth = "Login with Unsplash"
        static let title = "Unsplash"
    }
    
    enum Feed {
        static let authorPrefix = "author:" + Char.space
        static let datePrefix = "date:" + Char.space
    }
    
    enum Details {
        static let title = "Photo Stats"
        static let total = "Total"
        static let lastMonth = "30 Days"
    }
}
