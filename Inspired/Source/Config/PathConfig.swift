// MARK: PathConfig

enum PathConfig {
    static let coreDataModelName = "Inspired"
    
    static let key = "901e46dd899072b38fcc1606e8c1ff0e9e1e794d1ee0d1ebde048581b4d435a3"
    static let secret = "93c05ccf6e237446e38e44fe06c88d7d8c99221d83159a7ff4d4e162349188e7"
    
    static let baseUrl = "https://api.unsplash.com/"
    static let photos = baseUrl + "photos/?client_id=" + key
}
