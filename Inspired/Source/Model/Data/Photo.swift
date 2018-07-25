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
    
    var cellHeight: CGFloat {
        return heightForFullWidth + 200
    }
    
    // MARK: Init
    
    init(json: Json) {
        self.width = (json[Keys.width.rawValue] as? CGFloat) ?? 0
        self.height = (json[Keys.height.rawValue] as? CGFloat) ?? 0
        
        let user: Json = (json[Keys.user.rawValue] as? Json) ?? [:]
        self.name = (user[Keys.name.rawValue] as? String) ?? ""
        
        let urls: Json = (json[Keys.urls.rawValue] as? Json) ?? [:]
        self.fullUrl = (urls[Keys.full.rawValue] as? String) ?? ""
        self.regularUrl = (urls[Keys.regular.rawValue] as? String) ?? ""
    }
    
    // MARK: Keys
    
    enum Keys: String {
        case user, name, width, height, urls, full, regular
    }
}
