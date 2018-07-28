import  Foundation

// MARK: Path

enum Path {
    
    // MARK: Persistence
    
    enum Persistence {
        static let modelName = "Inspired"
    }
    
    // MARK: Unsplash
    
    enum Unsplash {
        
        enum Api {
            static var feed: URL? = Url.make(Base.url, [Route.photos], Param.feedCount(30))
            
            static func stats(id: String) -> URL? {
                return Url.make(Base.url, Route.stats(id), Param.stats(id))
            }
        }
        
        enum Base {
            static let url = "https://api.unsplash.com/"
            static let key = "901e46dd899072b38fcc1606e8c1ff0e9e1e794d1ee0d1ebde048581b4d435a3"
            static let secret = "93c05ccf6e237446e38e44fe06c88d7d8c99221d83159a7ff4d4e162349188e7"
        }
        
        private enum Route {
            static let photos = "photos"
            static let statistics = "statistics"
            static func stats(_ id: String) -> Url.Route { return [photos, id, statistics] }
        }
        
        private enum Param {
            static var clientId = "client_id"
            static let id = "id"
            static let count = "per_page"
            static let order = "order_by"
            static let popular = "popular"
            
            static let onlyClient = [clientId: Base.key]
            
            static func feedCount(_ value: Int) -> Url.Param {
                return [clientId: Base.key, count: String(value), order: popular]
            }
            
            static func stats(_ id: String) -> Url.Param { return [clientId: Base.key, self.id: id] }
        }
    }
}
