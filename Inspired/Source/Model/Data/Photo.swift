import CoreGraphics

// MARK: Photo

final class Photo {
    
    // MARK: Properties
    
    let id: String
    let name: String
    let desc: String
    let date: String
    let fullUrl: String
    let regularUrl: String
    let smallUrl: String
    let width: CGFloat
    let height: CGFloat
    
    // MARK: Init
    
    init(json: Json) {
        self.id = parseString(json, Keys.id.rawValue)
        self.width = parseFloat(json, Keys.width.rawValue)
        self.height = parseFloat(json, Keys.height.rawValue)
        self.desc = parseString(json, Keys.description.rawValue)
        self.date = parseString(json, Keys.date.rawValue)
        
        let user = parseJson(json, Keys.user.rawValue)
        self.name = parseString(user, Keys.name.rawValue)
        
        let urls = parseJson(json, Keys.urls.rawValue)
        self.fullUrl = parseString(urls, Keys.full.rawValue)
        self.regularUrl = parseString(urls, Keys.regular.rawValue)
        self.smallUrl = parseString(urls, Keys.small.rawValue)
    }
    
    // MARK: Keys
    
    enum Keys: String {
        case id, user, name, date = "created_at", description, width, height, urls, full, regular, small
    }
}
