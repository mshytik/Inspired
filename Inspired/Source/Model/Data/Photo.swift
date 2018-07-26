import CoreGraphics

// MARK: Photo

final class Photo {
    
    // MARK: Properties
    
    let name: String
    let fullUrl: String
    let regularUrl: String
    let width: CGFloat
    let height: CGFloat
    
    var heightForFullWidth: CGFloat {
        return Screen.bounds.width * (height / width)
    }
    
    // MARK: Init
    
    init(json: Json) {
        self.width = parseFloat(json, Keys.width.rawValue)
        self.height = parseFloat(json, Keys.height.rawValue)
        
        let user = parseJson(json, Keys.user.rawValue)
        self.name = parseString(user, Keys.name.rawValue)
        
        let urls = parseJson(json, Keys.urls.rawValue)
        self.fullUrl = parseString(urls, Keys.full.rawValue)
        self.regularUrl = parseString(urls, Keys.regular.rawValue)
    }
    
    // MARK: Keys
    
    enum Keys: String {
        case user, name, width, height, urls, full, regular
    }
}
