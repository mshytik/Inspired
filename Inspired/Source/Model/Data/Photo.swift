import CoreGraphics

// MARK: Photo

final class Photo {
    
    // MARK: Properties
    
    let fullUrl: String
    let regularUrl: String
    let width: CGFloat
    let height: CGFloat
    
    var heightForFullWidth: CGFloat {
        return Screen.bounds.width * (height / width)
    }
    
    // MARK: Init
    
    init(json: Json) {
        self.width = (json[Keys.width.rawValue] as? CGFloat) ?? 0
        self.height = (json[Keys.height.rawValue] as? CGFloat) ?? 0
        
        let urls: Json = (json[Keys.urls.rawValue] as? Json) ?? [:]
        self.fullUrl = (urls[Keys.full.rawValue] as? String) ?? ""
        self.regularUrl = (urls[Keys.regular.rawValue] as? String) ?? ""
    }
    
    // MARK: Keys
    
    enum Keys: String {
        case width, height, urls, full, regular
    }
}
