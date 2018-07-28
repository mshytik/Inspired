import Foundation

// MARK: PhotoStatItem

final class PhotoStatItem {
    let date: String
    let value: Int
    
    init(date: String, value: Int) {
        self.date = date
        self.value = value
    }
}

// MARK: PhotoStat

final class PhotoStat {
    let name: String
    let periodValue: Int
    let totalValue: Int
    let items: [PhotoStatItem]
    
    init(name: String, periodValue: Int, totalValue: Int, items: [PhotoStatItem]) {
        self.name = name
        self.periodValue = periodValue
        self.totalValue = totalValue
        self.items = items
    }
}

// MARK: PhotoStats

final class PhotoStats {
    let id: String
    let stats: [PhotoStat]
    
    init(id: String, stats: [PhotoStat]) {
        self.id = id
        self.stats = stats
    }
}
